# frozen_string_literal: true

require 'test_helper'
require 'webmock/minitest'

class CharactersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Añadir helpers de Devise

  setup do
    @admin_user = users(:admin)
    @regular_user = users(:regular)
    stub_api_marvel
  end
  test 'admin should get index' do
    sign_in @admin_user
    get characters_url
    assert_response :success
  end

  test 'regular user should not get new' do
    sign_in @regular_user
    get new_character_url
    assert_response :forbidden
  end

  test 'unauthenticated user should be redirected' do
    get new_character_url
    assert_response :redirect, 'Unauthenticated user should be redirected'
  end

  test 'admin should not save a character without attributes' do
    sign_in @admin_user
    character = Character.new
    assert_not character.save, 'Saved a character without attributes'
  end

  test 'admin should save a character with attributes' do
    sign_in @admin_user
    character = Character.new(name: 'Test Character', description: 'Test Description', user_id: @admin_user.id)
    assert character.save, 'Did not save a character with attributes'
  end

  test 'admin should not save a character without a name' do
    sign_in @admin_user
    character = Character.new(description: 'Test Description', user_id: @admin_user.id)
    assert_not character.save, 'Saved a character without a name'
  end

  test 'should get characters from Marvel API' do
    mock_data = stub_api_marvel
    assert_equal 'Iron Man', mock_data[:data][:results][0][:name]
  end
end
