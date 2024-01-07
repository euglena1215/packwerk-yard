# typed: strict
# frozen_string_literal: true

module PackwerkYard
  class Parser
    extend T::Sig
    include Packwerk::FileParser

    sig { params(ruby_parser: T.nilable(Packwerk::Parsers::Ruby)).void }
    def initialize(ruby_parser: Packwerk::Parsers::Ruby.new)
      @ruby_parser = ruby_parser
    end

    sig { override.params(io: T.any(IO, StringIO), file_path: String).returns(T.untyped) }
    def call(io:, file_path: "<unknown>")
      source_code = io.read
      return to_ruby_ast(nil.inspect, file_path) if source_code.nil?

      yard_handler = YardHandler.from_source(source_code)
      types = yard_handler.return_types | yard_handler.param_types

      to_ruby_ast(
        types.map { |type| ConstantizeType.new(type).types }.flatten
             .inspect.delete('"'),
        file_path,
      )
    end

    sig { override.params(path: String).returns(T::Boolean) }
    def match?(path:)
      path.end_with?(".rb")
    end

    private

    sig { params(code: String, file_path: T.untyped).returns(T.untyped) }
    def to_ruby_ast(code, file_path)
      T.must(@ruby_parser).call(
        io: StringIO.new(code),
        file_path: file_path,
      )
    end
  end
end
