class CharactersController < ApplicationController
  def new
    @character = Character.new
    @character.name = "Spider-man"
  end

  def create
    @character = Character.create(name: params[:character][:name])
    render json: @character
  end
end
