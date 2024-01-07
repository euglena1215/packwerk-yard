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

      types = extract_from_yard_to_types(source_code)

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

    sig { params(source_code: String).returns(T::Array[String]) }
    def extract_from_yard_to_types(source_code)
      YARD::Registry.clear
      YARD::Logger.instance.enter_level(YARD::Logger::ERROR) do
        YARD::Parser::SourceParser.parse_string(source_code)
      end

      types = YARD::Registry.all(:method).each_with_object([]) do |method_object, arr|
        method_object.tags("param").each do |tag|
          arr.concat(tag.types) if tag.types
        end

        return_tag = method_object.tag("return")
        arr.concat(return_tag.types) if return_tag&.types
      end

      types.uniq
    end

    sig { params(code: String, file_path: T.untyped).returns(T.untyped) }
    def to_ruby_ast(code, file_path)
      T.must(@ruby_parser).call(
        io: StringIO.new(code),
        file_path: file_path,
      )
    end
  end
end
