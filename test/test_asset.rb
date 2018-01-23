require 'test_helper'

context "#FuckYeahArchive::Asset" do
  context "fully qualified" do
    setup do
      source = "http://www.example.com/somewhere.md"
      image = "http://www.example.com/blah.jpg"
      FuckYeahArchive::Asset.new(source, image)
    end

    asserts("url") { topic.url }.equals("http://www.example.com/blah.jpg")
  end

  context "absolute" do
    setup do
      source = "http://www.example.com/doc/somewhere.html"
      image = "/images/blah.jpg"
      FuckYeahArchive::Asset.new(source, image)
    end

    asserts("url") { topic.url }.equals("http://www.example.com/images/blah.jpg")
  end

  context "relative to doc" do
    setup do
      source = "http://www.example.com/docs/somewhere.html"
      image = "../images/blah.jpg"
      FuckYeahArchive::Asset.new(source, image)
    end

    asserts("url") { topic.url }.equals("http://www.example.com/images/blah.jpg")
  end

  context "relative to index" do
    setup do
      source = "http://www.example.com/docs/"
      image = "../images/blah.jpg"
      FuckYeahArchive::Asset.new(source, image)
    end

    asserts("url") { topic.url }.equals("http://www.example.com/images/blah.jpg")
  end

end
