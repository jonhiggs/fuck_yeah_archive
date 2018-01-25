require 'test_helper'

context "#FuckYeahArchive::Document" do
  context "sample/1.md" do
    setup do
      sample_file = File.join(File.dirname(__FILE__), "./samples/1.md")
      FuckYeahArchive::Document.new(File.read(sample_file))
    end

    asserts("title") { topic.title }.equals("The Heading")
    asserts("slug") { topic.slug }.equals("the-heading")
    asserts("source") { topic.source }.equals("http://example.com/blah.html")
    asserts("file") { topic.file }.matches(/20[0-9]{6}-the-heading\.md/)
    asserts("asset_directory") { topic.asset_directory }.matches(/20[0-9]{6}-the-heading/)

    context "article" do
      asserts("start position") { topic.article.split("\n")[1] }.equals('this is [link1][1].')
      asserts("end position") { topic.article.split("\n")[-1] }.equals('an image ![within][5] a sentence')
      asserts("size") { topic.article.split("\n").size }.equals(11)
    end

    context "refs" do
      asserts("size") { topic.refs }.size(5)
      asserts("1") { topic.refs[1] }.equals("http://www.google.com/")
      asserts("2") { topic.refs[2] }.equals("blah2.jpg")
      asserts("3") { topic.refs[3] }.equals("http://www.google.com/blah3.jpg")
      asserts("4") { topic.refs[4] }.equals("blah4.jpg")
      asserts("5") { topic.refs[5] }.equals("another.jpg")
    end

    context "image_refs" do
      asserts("size") { topic.image_refs }.size(4)
      asserts("2") { topic.image_refs[2] }.equals("blah2.jpg")
      asserts("3") { topic.image_refs[3] }.equals("http://www.google.com/blah3.jpg")
      asserts("4") { topic.image_refs[4] }.equals("blah4.jpg")
      asserts("5") { topic.image_refs[5] }.equals("another.jpg")
    end

    context "image_ref_ids" do
      asserts("size") { topic.image_ref_ids }.equals([2,3,4,5])
    end

  end
end
