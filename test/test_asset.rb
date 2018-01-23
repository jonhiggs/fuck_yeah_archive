require 'test_helper'

context "#FuckYeahArchive::Asset" do
  context "url" do
    context "when fully qualified" do
      setup do
        source = "http://www.example.com/somewhere.md"
        image = "http://www.example.com/blah.jpg"
        FuckYeahArchive::Asset.new(source, image)
      end

      asserts("url") { topic.url.to_s }.equals("http://www.example.com/blah.jpg")
    end

    context "when absolute" do
      setup do
        source = "http://www.example.com/doc/somewhere.html"
        image = "/images/blah.jpg"
        FuckYeahArchive::Asset.new(source, image)
      end

      asserts("url") { topic.url.to_s }.equals("http://www.example.com/images/blah.jpg")
    end

    context "when relative to doc" do
      setup do
        source = "http://www.example.com/docs/somewhere.html"
        image = "../images/blah.jpg"
        FuckYeahArchive::Asset.new(source, image)
      end

      asserts("url") { topic.url.to_s }.equals("http://www.example.com/images/blah.jpg")
    end

    context "when relative to index" do
      setup do
        source = "http://www.example.com/docs/"
        image = "../images/blah.jpg"
        FuckYeahArchive::Asset.new(source, image)
      end

      asserts("url") { topic.url.to_s }.equals("http://www.example.com/images/blah.jpg")
    end
  end

  context "output_file" do
    setup do
      source = "http://www.example.com/somewhere.md"
      image = "http://www.example.com/blah.jpg"
      FuckYeahArchive::Asset.new(source, image, "/tmp/heading")
    end

    asserts("output_file") { topic.output_file }.equals("/tmp/heading/blah.jpg")
  end

end
