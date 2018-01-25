require 'erb'
require 'ostruct'

class ErbalT < OpenStruct
  def render(template)
    ERB.new(template).result(binding)
  end
end

module FuckYeahArchive
  class Markdown
    def initialize(url)
      data = Net::HTTP.start(url.hostname) { |http| http.get(url.path).body }
      @document = FuckYeahArchive::Document.new(data)
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
      puts ErbalT::render_from_hash(template, vars)
    end
  end
end
