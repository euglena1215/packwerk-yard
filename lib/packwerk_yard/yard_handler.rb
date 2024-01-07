# typed: strict
# frozen_string_literal: true

module PackwerkYard
  class YardHandler
    extend T::Sig

    sig { returns(T::Array[String]) }
    attr_reader :return_types

    sig { returns(T::Array[String]) }
    attr_reader :param_types

    sig { params(return_types: T::Array[String], param_types: T::Array[String]).void }
    def initialize(return_types, param_types)
      @return_types = return_types
      @param_types = param_types
    end

    class << self
      extend T::Sig

      sig { params(code: String).returns(YardHandler) }
      def from_source(code)
        YARD::Registry.clear
        YARD::Logger.instance.enter_level(YARD::Logger::ERROR) do
          YARD::Parser::SourceParser.parse_string(code)
        end

        return_types = []
        param_types = []

        YARD::Registry.all(:method).each do |method_object|
          method_object.tags("param").each do |tag|
            param_types << tag.types if tag.types
          end

          return_tag = method_object.tag("return")
          return_types << return_tag.types if return_tag&.types
        end

        new(return_types.flatten.uniq, param_types.flatten.uniq)
      end
    end
  end
end
