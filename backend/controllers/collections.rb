class ArchivesSpaceService < Sinatra::Base

  Endpoint.get('/repositories/:repo_id/collections')
    .description("Collection list for the public interface")
    .params(["repo_id", :repo_id])
    .permissions([])
    .returns([200, "OK"]) \
  do
    json = generate_list
    json_response(json)
  end

  private

  def generate_list
    json = {}
    keys = ['B','D','M','U']
    keys.each{|k| json[k] = []}

    dataset = CrudHelpers.scoped_dataset(Resource, {})

    dataset.each do |data|
      keys.each do |k|
        if data[:id_0].start_with?(k) && data[:publish] == 1
          json[k].push({
            'uri' => "/repositories/#{params[:repo_id]}/resources/#{data[:id]}",
            'title' => "#{data[:id_0]} #{data[:title]}"
          })
        end
      end
    end

    keys.each{|k| json[k].sort_by!{|hsh| hsh['title']}}
    json
  end
end
