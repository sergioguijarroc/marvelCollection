# frozen_string_literal: true

class CharactersController < ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user!, only: %i[new create edit update destroy from_user]
  before_action :find_character, except: %i[new create index from_user export]
  before_action :load_characters, only: %i[index from_user export]
  before_action :authorize_character, except: %i[index new create from_user export]

  def new
    @comics = Comic.all
    @character = Character.new
    authorize @character
    return if params[:user_id]

    @users = User.all
    nil
  end

  def create
    @character = Character.new(permit_params)
    authorize @character

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

  def show
    @comics = @character.comics
  end

  def edit
    @users = User.all
    @comics = Comic.all
  end

  def update
    if @character.update(permit_params)
      redirect_to @character
    else
      @users = User.all
      @comics = Comic.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
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
  end

  private

  def find_character
    @character = Character.find(params[:id])
  end

  def load_characters
    characters = Character.all
    @characters = CharacterFilter.new(characters, params).call
  end

  def permit_params
    params.require(:character).permit(:name, :description, :user_id, :image_url,
                                      comic_ids: []).reverse_merge(comic_ids: [])
  end

  def authorize_character
    authorize @character
  end
end
