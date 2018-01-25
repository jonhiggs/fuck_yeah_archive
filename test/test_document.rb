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

  context "sample/2.md" do
    setup do
      sample_file = File.join(File.dirname(__FILE__), "./samples/2.md")
      FuckYeahArchive::Document.new(File.read(sample_file))
    end

    asserts("title") { topic.title }.equals("The Many Acts of Keith Gordon")
    asserts("slug") { topic.slug }.equals("the-many-acts-of-keith-gordon")
    asserts("source") { topic.source }.equals("https://longreads.com/2018/01/25/the-many-acts-of-keith-gordon/")
    asserts("file") { topic.file }.matches(/20[0-9]{6}-the-many-acts-of-keith-gordon\.md/)
    asserts("asset_directory") { topic.asset_directory }.matches(/20[0-9]{6}-the-many-acts-of-keith-gordon/)

    context "article" do
      asserts("start position") { topic.article.split("\n")[1] }.equals('_David Obuchowski | [The Awl][1] and Longreads | January 2018 | 34 minutes (8,481 words)_')
      asserts("end position") { topic.article.split("\n")[-1] }.equals('### _Related_')
      asserts("size") { topic.article.split("\n").size }.equals(245)
    end

    context "refs" do
      asserts("size") { topic.refs }.size(16)
    end

    context "image_refs" do
      asserts("2") { topic.image_refs.keys }.includes(2)
      asserts("3") { topic.image_refs.keys }.includes(3)
      asserts("5") { topic.image_refs.keys }.includes(5)
      asserts("8") { topic.image_refs.keys }.includes(8)
      asserts("9") { topic.image_refs.keys }.includes(9)
      asserts("10") { topic.image_refs.keys }.includes(10)
      asserts("12") { topic.image_refs.keys }.includes(12)
      asserts("14") { topic.image_refs.keys }.includes(14)
    end

    context "image_ref_ids" do
      asserts("size") { topic.image_ref_ids }.equals([2,3,5,8,9,10,12,14])
    end

  end
end
