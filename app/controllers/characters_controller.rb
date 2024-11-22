class CharactersController < ApplicationController
  # Inicializa un nuevo objeto Character y prepara el formulario
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :find_character, except: %i[new create index]
  # Esto es para obligar que el usuario esté logueado para acceder a estas vistas

  def new
    @character = Character.new
  end

  # Maneja la creación de un nuevo Character a partir de los datos del formulario
  def create
    # @character = Character.create(
    #   name: params[:character][:name], description: params[:character][:description], user_id: current_user.id
    # )
    @character = current_user.characters.create(
      name: params[:character][:name], description: params[:character][:description]
    )
    # De esta forma, no hace falta especificarle el user_id, ya que se lo estamos asignando al current user y ruby
    # lo pone solo
    redirect_to @character
  end

  # Muestra un Character específico basado en su id
  def show; end

  def edit; end

  def update
    @character = Character.find(params[:id])
    @character.update(name: params[:character][:name], description: params[:character][:description])

    redirect_to @character # Redirige a la vista show
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to characters_path
  end

  def index
    @characters = Character.all
  end

  def from_user
    
  end

  def find_character
    @character = Character.find(params[:id])
  end
end
