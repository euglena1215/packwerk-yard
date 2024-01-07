# typed: false
# frozen_string_literal: true

require "test_helper"

module PackwerkYard
  class ConstantizeTypeTest < Minitest::Test
    def test_types_returns_constantize_types_with_primitive_value
      types = PackwerkYard::ConstantizeType.new("String").types

      assert_equal(1, types.size)
      assert_equal("String", types[0])
    end

    def test_types_returns_constantize_types_with_simple_array
      types = PackwerkYard::ConstantizeType.new("Array<String>").types

      assert_equal(["String"], types)
    end

    def test_types_returns_constantize_types_with_nested_array
      types = PackwerkYard::ConstantizeType.new("Array<Array<String>>").types

      assert_equal(["String"], types)
    end

    def test_types_returns_constantize_types_with_simple_hash
      types = PackwerkYard::ConstantizeType.new("Hash<Integer, String>").types

      assert_equal(["Integer", "String"], types)
    end

    def test_types_returns_constantize_types_with_nested_hash
      types = PackwerkYard::ConstantizeType.new("Hash<Integer, Hash<String, Integer>>").types

      assert_equal(["Integer", "String"], types)
    end

    def test_types_returns_constantize_types_with_hash_specific_format
      types = PackwerkYard::ConstantizeType.new("Hash{Integer => String}").types
      assert_equal(["Integer", "String"], types)

      types = PackwerkYard::ConstantizeType.new("Hash{Integer=>String}").types
      assert_equal(["Integer", "String"], types)
    end

    def test_types_returns_constantize_types_with_not_existing_class
      types = PackwerkYard::ConstantizeType.new("NotExistsClass").types

      assert_equal([], types)
    end
  end
end
