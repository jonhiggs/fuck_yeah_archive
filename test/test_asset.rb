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

    context "when has query strings" do
      setup do
        source = "http://www.example.com/docs/"
        image = "https://longreadsblog.files.wordpress.com/2018/01/gettyimages-125626049.jpg?w=415&h=582"
        FuckYeahArchive::Asset.new(source, image)
      end

      asserts("url") { topic.url.to_s }.equals("https://longreadsblog.files.wordpress.com/2018/01/gettyimages-125626049.jpg")
    end
  end

  #context "fetch" do
  #  setup do
  #    source = "http://www.example.com/somewhere.md"
  #    image = "http://www.majiroxnews.com/wordpress/wp-content/uploads/2011/04/cow1.jpg"
  #    FuckYeahArchive::Asset.new(source, image).fetch
  #  end

  #  asserts("file size") { topic.size }.equals(420040)
  #end

end
