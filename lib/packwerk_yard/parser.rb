# frozen_string_literal: true

module PackwerkYard
  class Parser # rubocop:disable Style/Documentation
    include Packwerk::FileParser

    def initialize(ruby_parser: Packwerk::Parsers::Ruby.new)
      @ruby_parser = ruby_parser
    end

    def call(io:, file_path: "<unknown>")
      source_code = io.read
      return to_ruby_ast(nil.inspect, file_path + ".yard") if source_code.nil?

      types = extract_from_yard_to_types(source_code)

      to_ruby_ast(types.map { |type| to_constant(type) }.compact.inspect, file_path + ".yard")
    end

    def match?(path:)
      path.end_with?(".rb")
    end

    private

    def extract_from_yard_to_types(source_code)
      # TODO: parallel で packwerk が動作すると競合が発生する可能性があるため調査する
      YARD::Registry.clear
      YARD::Parser::SourceParser.parse_string(source_code)

      types = YARD::Registry.all(:method).each_with_object([]) do |method_object, arr|
        method_object.tags("param").each do |tag|
          arr.concat(tag.types) if tag.types
        end

        return_tag = method_object.tag("return")
        arr.concat(return_tag.types) if return_tag&.types
      end

      types.uniq
    end

    def to_constant(name)
      Object.const_get(name)
    rescue NameError
      nil
    end

    def to_ruby_ast(code, file_path)
      @ruby_parser.call(
        io: StringIO.new(code),
        file_path: file_path
      )
    end
  end
end
