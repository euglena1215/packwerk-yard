# typed: false
# frozen_string_literal: true

module PackwerkYard
  class YardHandlerTest < Minitest::Test
    def test_from_source_with_simple_param_and_return
      code = <<~RUBY
        class Foo
          # @param [String] foo
          # @return [String]
          def bar(foo)
            foo
          end
        end
      RUBY

      handler = PackwerkYard::YardHandler.from_source(code)

      assert_equal(["String"], handler.param_types)
      assert_equal(["String"], handler.return_types)
    end

    def test_from_source_with_multiple_param
      code = <<~RUBY
        class Foo
          # @param [String] foo
          # @param [Integer] bar
          def baz(foo, bar)
          end
        end
      RUBY

      handler = PackwerkYard::YardHandler.from_source(code)

      assert_equal(["String", "Integer"], handler.param_types)
    end

    def test_from_source_with_nested_array
      code = <<~RUBY
        class Foo
          # @param [Array<Array<String>>] foo
          # @return [Array<Array<String>>]
          def bar(foo)
            foo
          end
        end
      RUBY

      handler = PackwerkYard::YardHandler.from_source(code)

      assert_equal(["Array<Array<String>>"], handler.param_types)
      assert_equal(["Array<Array<String>>"], handler.return_types)
    end

    def test_from_source_with_polymorphic_param_and_return
      code = <<~RUBY
        class Foo
          # @param [String, Integer] foo
          # @return [String, Integer]
          def bar(foo)
            foo
          end
        end
      RUBY

      handler = PackwerkYard::YardHandler.from_source(code)

      assert_equal(["String", "Integer"], handler.param_types)
      assert_equal(["String", "Integer"], handler.return_types)
    end
  end
end
