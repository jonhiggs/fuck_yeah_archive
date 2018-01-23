require 'uri'

module FuckYeahArchive
  class Asset
    def initialize(source, image)
      @source = URI(source)
      @image = URI(image)
    end

    def url
      if @image.class.to_s == "URI::Generic"
        if absolute_path?(@image)
          "#{@source.scheme}://#{@source.hostname}#{@image.path}"
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
          "#{@source.scheme}://#{@source.hostname}#{p}"
        end
      else
        "#{@image.scheme}://#{@image.hostname}#{@image.path}"
      end
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

#source $(dirname "${BASH_SOURCE[0]}")/page.sh
#source $(dirname "${BASH_SOURCE[0]}")/slug.sh
#
#_asset_url() {
#  ref_source=$(_page_ref_source $1)
#  if [[ "${ref_source}" =~ ^https ]]; then
#    echo "${ref_source}"
#  else
#    echo "$(_page_source)$(_page_ref_source $1)"
#  fi
#}
#
#_asset_filename() {
#  ref=$1
#  slug=$(_slug "$(_page_heading)")
#  dir=$(_asset_directory "${slug}")
#  file="$(basename $(_asset_url "${ref}"))"
#  echo "${dir}/${file}"
#}
