# frozen_string_literal: true

class CharacterFilter
  def initialize(characters, params)
    @params = params
    @characters = characters
  end

  def call
    search_filter_characters(@characters, @params)
  end

  private

  attr_reader :params

  def search_filter_characters(characters, params)
    characters = characters.where(user_id: params[:user_id]) if params[:user_id].present?
    characters = characters.where('name LIKE ?', "%#{params[:search_name]}%") if params[:search_name].present?
    characters
  end
end
