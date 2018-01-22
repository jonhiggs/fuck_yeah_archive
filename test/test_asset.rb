require './test_helper.rb'

context "#FuckYeahArchive::Asset" do
  context "fully qualified" do
    setup do
      source = "http://www.example.com/somewhere.md"
      image = "http://www.example.com/blah.jpg"
      FuckYeahArchive::Asset.new(source, image)
    end

    asserts("url") { topic.url }.equals("http://www.example.com/blah.jpg")

  end

  context "relative" do
    setup do
      source = "http://www.example.com/somewhere.md"
      image = "blah.jpg"
      FuckYeahArchive::Asset.new(source, image)
    end

    asserts("url") { topic.url }.equals("http://www.example.com/blah.jpg")

  end

end
