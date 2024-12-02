class CharactersController < ApplicationController
  # Inicializa un nuevo objeto Character y prepara el formulario
  before_action :authenticate_user!, only: %i[new create edit update destroy from_user]
  before_action :find_character, except: %i[new create index from_user export]
  before_action :load_characters, only: %i[index from_user export]

  def new
    @comics = Comic.all
    @character = Character.new
    return if params[:user_id]

    @users = User.all
    nil
  end

  # Maneja la creación de un nuevo Character a partir de los datos del formulario
  def create
    @character = Character.new(permit_params)

    image_url = MarvelServices::GetCharacterImage.new(@character.name).call

    @character.image_url = image_url if image_url.present?

    @character.user_id = current_user.id if permit_params[:user_id].blank?

    if @character.save
      UpdateCharacterSeriesJob.perform_async(@character.id)
      redirect_to @character
    else
      @comics = Comic.all
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end

  # Muestra un Character específico basado en su id
  def show
    @comics = @character.comics
  end

  def edit
    @users = User.all
    @comics = Comic.all
  end

  def update
    @character = Character.find(params[:id])
    if @character.update(permit_params) # si se actualiza correctamente con los datos del formulario
      redirect_to @character # Redirige a la vista show
    else
      @users = User.all
      @comics = Comic.all
      render :edit, status: :unprocessable_entity
    end
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

  def export
    send_data(GenerateCharactersCsv.new(@characters).call, filename: 'test.csv')
    # redirect_to characters_path, notice: 'CSV exported'
  end

  # Before action
  def find_character
    @character = Character.find(params[:id])
  end

  def load_characters
    characters = Character.all
    @characters = CharacterFilter.new(characters, params).call
  end

  # def set_comics
  #   params[:character][:comic_ids] ||= []
  # end

  # Permit params
  def permit_params
    params.require(:character).permit(:name, :description, :user_id, :image_url,
                                      comic_ids: []).reverse_merge(comic_ids: [])
  end
end
