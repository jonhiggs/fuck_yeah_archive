require './test_helper.rb'

context "#FuckYeahArchive::Document" do
  context "sample/1.md" do
    setup do
      sample = "./samples/1.md"
      FuckYeahArchive::Document.new(sample)
    end

    asserts("heading") { topic.heading }.equals("The Heading")
    asserts("source") { topic.source }.equals("http://example.com/blah.html")

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
