require 'uri'
require 'net/http'

module FuckYeahArchive
  class FuckYeah
    def initialize(url)
      @url = URI.encode(url)
    end

    def markdown
      api_url = URI("http://fuckyeahmarkdown.com/go/?read=1&preview=0&showframe=0&showframe=0&output=markdown&u=#{@url}")
      byebug
      Net::HTTP.start(api_url.hostname) { |http| http.get(api_url.request_uri).body }
    end
  end
end
