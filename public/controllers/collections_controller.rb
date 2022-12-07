class CollectionsController < ApplicationController

  def index
		@page_title = "Collections List"
    @areas = {
      'B' => "Ira M. and Peryle Hayutin Beck Archives of Rocky Mountain Jewish History",
      'D' => "The Dance Archive",
      'M' => "Manuscript Collections",
      'U' => "University Archives"
    }

    @results = get_collections('/repositories/2/collections')

    render "collections/index"
  end

  private

  def get_collections(uri)
    url = URI.join("#{AppConfig[:backend_url]}", uri)
    request = Net::HTTP::Get.new(url)
    response = do_http_request(request)
    
    results = JSON.parse(response.body) unless response.code != "200"

    results
  end

  def do_http_request(request)
    url = request.uri
    
    Net::HTTP.start(url.host, url.port) do |http|
      http.use_ssl = true if url.scheme == 'https'
      response = http.request(request)

      response
    end
  end

end
