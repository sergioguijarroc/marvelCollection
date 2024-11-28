class MarvelServices::ComicService
  def initialize(comic_title)
    super()
    @comic_title = comic_title
  end

  def call
    response = HTTParty.get("#{BASE_URL}/comics", query: query_params(titleStartsWith: @comic_title))
    return nil unless response.success? && response['data']['results'].any?

    comic_data = response['data']['results'].first
    {
      image_url: "#{comic_data['thumbnail']['path']}.#{comic_data['thumbnail']['extension']}"
    }
  end
end
