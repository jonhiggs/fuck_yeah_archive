require 'erb'
require 'ostruct'

module FuckYeahArchive
  class Markdown
    def initialize(document)
      @document = document
    end

    def refs
      response = {}
      ref_types = @document.ref_types
      @document.refs.each do |id,ref|
        if ref_types[id] == ".html"
          response[id] = ref
        else
          response[id] = File.join(
            @document.asset_directory,
            "#{id}#{ref_types[id]}"
          )
        end
      end
      response
    end

    def render
      template = File.read(
        File.join(File.dirname(__FILE__), "../../template/markdown.erb")
      )
      vars = {
        :source => @document.source,
        :title => @document.title,
        :article => @document.article,
        :refs => refs,
      }
      ERB.new(template).result(OpenStruct.new(vars).instance_eval { binding })
    end
  end
end
