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
  end
end
