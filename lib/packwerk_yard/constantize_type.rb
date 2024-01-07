# typed: strict
# frozen_string_literal: true

module PackwerkYard
  class ConstantizeType
    extend T::Sig

    # Array Syntax e.g. Array<String>
    ARRAY_REGEXP = T.let(/\AArray<(.+)>/.freeze, Regexp)
    private_constant :ARRAY_REGEXP

    # Hash Syntax e.g. Hash<String, String>
    HASH_REGEXP = T.let(/\AHash<([^,\s]+)\s*,\s*(.+)>/.freeze, Regexp)
    private_constant :HASH_REGEXP

    # Hash Syntax e.g. Hash{String => String}
    HASH_SPECIFIC_REGEXP = T.let(/\AHash\{([^,\s]+)\s*=>\s*(.+)}/.freeze, Regexp)
    private_constant :HASH_SPECIFIC_REGEXP

    sig { params(yard_type: String).void }
    def initialize(yard_type)
      @yard_type = yard_type
    end

    sig { returns(T::Array[String]) }
    def types
      split_type(@yard_type).select { |type| constantize?(type) }.uniq
    end

    private

    sig { params(name: String).returns(T::Boolean) }
    def constantize?(name)
      Object.const_get(name) # rubocop:disable Sorbet/ConstantsFromStrings
      true
    rescue NameError
      false
    end

    sig { params(type: String).returns(T::Array[String]) }
    def split_type(type)
      matched_types = Array(ARRAY_REGEXP.match(type).to_a[1])
      matched_types = Array(HASH_REGEXP.match(type).to_a[1..2]) if matched_types.empty?
      matched_types = Array(HASH_SPECIFIC_REGEXP.match(type).to_a[1..2]) if matched_types.empty?
      matched_types.empty? ? [type] : matched_types.map { |t| split_type(t) }.flatten
    end
  end
end
