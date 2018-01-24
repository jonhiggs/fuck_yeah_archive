require 'uri'
require 'net/http'

module FuckYeahArchive
  class Asset
    def initialize(source, image, asset_dir=ENV["TMPDIR"])
      @source = URI(source)
      @image = URI(image)
      @asset_dir = asset_dir
    end

    def fetch
      FileUtils.mkdir_p(File.dirname(output_file))
      Net::HTTP.start(url.hostname) do |http|
        resp = http.get(url.path)
        open(output_file, "wb") do |file|
          file.write(resp.body)
        end
      end
    end

    def url
      if @image.class.to_s == "URI::Generic"
        if absolute_path?(@image)
          URI("#{@source.scheme}://#{@source.hostname}#{@image.path}")
        else
          if path_to_file? @source
            p = File.expand_path(
              File.join(
                File.dirname(@source.path), @image.path
              )
            )
          else
            p = File.expand_path(File.join(@source.path, @image.path))
          end
          URI("#{@source.scheme}://#{@source.hostname}#{p}")
        end
      else
        URI("#{@image.scheme}://#{@image.hostname}#{@image.path}")
      end
    end

    def output_file
      File.join(@asset_dir, File.basename(@image.path))
    end

    private
    def absolute_path? uri
      uri.path.match(/^\//)
    end

    def path_to_file? uri
      !uri.path.match(/\/$/)
    end
  end
end
