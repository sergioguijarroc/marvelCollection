class CharactersController < ApplicationController
  # Inicializa un nuevo objeto Character y prepara el formulario
  def new
    @character = Character.new
    @character.name = "Spider-man"
  end

  # Maneja la creación de un nuevo Character a partir de los datos del formulario
  def create
    @character = Character.create(name: params[:character][:name], description: params[:character][:description])
    render json: @character
  end

  # Muestra un Character específico basado en su id
  def show
    @character = Character.find(params[:id])
  end
end