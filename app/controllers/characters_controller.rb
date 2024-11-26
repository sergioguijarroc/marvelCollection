class CharactersController < ApplicationController
  # Inicializa un nuevo objeto Character y prepara el formulario
  before_action :authenticate_user!, only: %i[new create edit update destroy from_user]
  before_action :find_character, except: %i[new create index from_user]
  before_action :load_characters, only: %i[index from_user]
  # Esto es para obligar que el usuario esté logueado para acceder a estas vistas

  def new
    @character = Character.new
    return if params[:user_id]

    @users = User.all
    nil
  end

  # Maneja la creación de un nuevo Character a partir de los datos del formulario
  def create
    character_attributes = permit_params
    character_attributes[:user_id] = current_user.id if character_attributes[:user_id].blank?
    @character = Character.new(character_attributes)

    if @character.save
      redirect_to @character
      # Esto va a la acción show
    else
      @users = User.all
      render :new, status: :unprocessable_entity
      # Esto vuelve a renderizar la vista de new, sin pasar por la acción
    end
  end

  # Muestra un Character específico basado en su id
  def show; end

  def edit
    @users = User.all
  end

  def update
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
    @index = true
    @users = User.all
  end

  def from_user
    @user = User.find(params[:user_id])
    @characters = @user.characters.all
    @index = false
  end

  # Before action
  def find_character
    @character = Character.find(params[:id])
  end

  def load_characters
    @characters = Character.all
    @characters = CharacterFilter.new(@characters, params).call
  end

  # Permit params
  def permit_params
    params.require(:character).permit(:name, :description, :user_id)
  end
end
