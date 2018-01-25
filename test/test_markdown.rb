require 'test_helper'

context "#FuckYeahArchive::Markdown" do
  context "sample/1.md" do
    setup do
      FuckYeahArchive::Document.new(File.read("test/samples/1.md"))
    end
  end
end
