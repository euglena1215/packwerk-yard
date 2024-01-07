# typed: false
# frozen_string_literal: true

require "test_helper"

module PackwerkYard
  class ParserTest < Minitest::Test
    def test_call_returns_node_with_valid_file
      parser = ::PackwerkYard::Parser.new
      io = StringIO.new(File.read("test/fixtures/yard/valid.rb"))
      node = parser.call(io: io, file_path: "test/fixtures/yard/valid.rb")

      assert_instance_of(::Parser::AST::Node, node)
      assert(node.type, :array)
      assert(node.children[0].children[1], :String)
    end

    def test_call_return_node_with_not_exists_class_args_file
      parser = ::PackwerkYard::Parser.new
      io = StringIO.new(File.read("test/fixtures/yard/not_exists_class_args.rb"))
      node = parser.call(io: io, file_path: "test/fixtures/yard/not_exists_class_args.rb")

      assert_instance_of(::Parser::AST::Node, node)
      assert(node.type, :array)
      assert(node.children.size, 0)
    end

    def test_call_return_node_with_nested_array_file
      parser = ::PackwerkYard::Parser.new
      io = StringIO.new(File.read("test/fixtures/yard/nested_array.rb"))
      node = parser.call(io: io, file_path: "test/fixtures/yard/nested_array.rb")

      assert_instance_of(::Parser::AST::Node, node)
      assert(node.type, :array)
      assert(node.children[0].children[1], :String)
    end

    def test_call_return_node_with_nested_hash_file
      parser = ::PackwerkYard::Parser.new
      io = StringIO.new(File.read("test/fixtures/yard/nested_hash.rb"))
      node = parser.call(io: io, file_path: "test/fixtures/yard/nested_hash.rb")

      assert_instance_of(::Parser::AST::Node, node)
      assert(node.type, :array)
      assert(node.children[0].children[1], :String)
      assert(node.children[1].children[1], :Integer)
    end
  end
end
