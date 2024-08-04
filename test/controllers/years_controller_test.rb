# frozen_string_literal: true

require "test_helper"

class YearsControllerTest < ActionController::TestCase
  setup do
    @year = years(:year_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:years)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create year" do
    assert_difference("Year.count") do
      post :create, year: { audubon_year: @year.audubon_year, vashon_year: @year.vashon_year }
    end

    assert_redirected_to year_path(assigns(:year))
  end

  test "should show year" do
    get :show, id: @year
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @year
    assert_response :success
  end

  test "should update year" do
    patch :update, id: @year, year: { audubon_year: @year.audubon_year, vashon_year: @year.vashon_year }
    assert_redirected_to year_path(assigns(:year))
  end

  test "should destroy year" do
    assert_difference("Year.count", -1) do
      delete :destroy, id: @year
    end

    assert_redirected_to years_path
  end
end
