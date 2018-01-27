require 'test_helper'

context "#FuckYeahArchive::Markdown" do
  context "sample/2.md" do
    setup do
      input_doc = FuckYeahArchive::Document.new(File.read("test/samples/2.md"))
      FuckYeahArchive::Markdown.new(input_doc)
    end

    context "refs" do
      asserts("1") { topic.refs[1] }.equals("https://www.theawl.com/")
      asserts("2") { topic.refs[2] }.equals("20180128-the-many-acts-of-keith-gordon/2.gif")
      asserts("3") { topic.refs[3] }.equals("20180128-the-many-acts-of-keith-gordon/3.png")
      asserts("4") { topic.refs[4] }.equals("http://www.theawl.com/")
      asserts("5") { topic.refs[5] }.equals("20180128-the-many-acts-of-keith-gordon/5.jpg")
    end
  end
end
