# frozen_string_literal: true

require "test_helper"

class SurveysControllerTest < ActionController::TestCase
  setup do
    @survey = surveys(:survey_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survey" do
    assert_difference("Survey.count") do
      post :create, survey: { date: @survey.date, year_id: @survey.year_id }
    end

    assert_redirected_to survey_path(assigns(:survey))
  end

  test "should show survey" do
    get :show, id: @survey
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @survey
    assert_response :success
  end

  test "should update survey" do
    patch :update, id: @survey, survey: { date: @survey.date, year_id: @survey.year_id }
    assert_redirected_to survey_path(assigns(:survey))
  end

  test "should destroy survey" do
    assert_difference("Survey.count", -1) do
      delete :destroy, id: @survey
    end

    assert_redirected_to surveys_path
  end
end
