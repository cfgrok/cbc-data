# frozen_string_literal: true

require "test_helper"

class AreasControllerTest < ActionController::TestCase
  setup do
    @area = areas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create area" do
    assert_difference("Area.count") do
      post :create, area: { name: @area.name, sector_id: @area.sector_id }
    end

    assert_redirected_to area_path(assigns(:area))
  end

  test "should show area" do
    get :show, id: @area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @area
    assert_response :success
  end

  test "should update area" do
    patch :update, id: @area, area: { name: @area.name, sector_id: @area.sector_id }
    assert_redirected_to area_path(assigns(:area))
  end

  test "should destroy area" do
    assert_difference("Area.count", -1) do
      delete :destroy, id: @area
    end

    assert_redirected_to areas_path
  end
end
