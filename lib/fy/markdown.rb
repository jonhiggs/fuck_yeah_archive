require 'erb'
require 'ostruct'

module FuckYeahArchive
  class Markdown
    def initialize(document)
      @document = document
    end

    def render
      template = File.read(
        File.join(File.dirname(__FILE__), "../../template/markdown.erb")
      )
      vars = {
        :source => @document.source,
        :title => @document.title,
        :article => @document.article,
        :references => @document.refs,
      }
      ERB.new(template).result(OpenStruct.new(vars).instance_eval { binding })
    end
  end
end
