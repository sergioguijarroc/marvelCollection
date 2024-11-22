class CharactersController < ApplicationController
  # Inicializa un nuevo objeto Character y prepara el formulario
  before_action :authenticate_user!, only: %i[new create edit update destroy from_user]
  before_action :find_character, except: %i[new create index from_user]
  # Esto es para obligar que el usuario esté logueado para acceder a estas vistas

  def new
    @character = Character.new
    return if params[:user_id]

    @users = User.all
    nil
  end

  # Maneja la creación de un nuevo Character a partir de los datos del formulario
  def create
    # @character = Character.create(
    #   name: params[:character][:name], description: params[:character][:description], user_id: current_user.id
    @character = Character.create(
      name: params[:character][:name],
      description: params[:character][:description],
      user_id: params[:character][:user_id] || current_user.id
    )
    # De esta forma, no hace falta especificarle el user_id, ya que se lo estamos asignando al current user y ruby
    # lo pone solo
    redirect_to @character
  end

  # Muestra un Character específico basado en su id
  def show; end

  def edit
    @users = User.all
  end

  def update
    @character = Character.find(params[:id])
    @character.update(name: params[:character][:name],
                      description: params[:character][:description],
                      user_id: params[:character][:user_id] || current_user.id)
    redirect_to @character # Redirige a la vista show
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to characters_path
  end

  def index
    @characters =
      if params[:user_id].present?
        Character.where(user_id: params[:user_id]) if params[:search_name].present?
      elsif params[:search_name].present?
        Character.where('name LIKE ?', "%#{params[:search_name]}%")
      else
        Character.all
      end
    @index = true
    @users = User.all
  end

  def from_user
    @user = User.find(params[:user_id])
    @characters = @user.characters.all
    @index = false
  end

  def find_character
    @character = Character.find(params[:id])
  end
end
