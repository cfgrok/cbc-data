# frozen_string_literal: true

require "test_helper"

class ChecklistsControllerTest < ActionController::TestCase
  setup do
    @checklist = checklists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checklists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checklist" do
    assert_difference("Checklist.count") do
      post :create, checklist: { area_id: @checklist.area_id, end_time: @checklist.end_time, feeder_watch: @checklist.feeder_watch, hours_boat: @checklist.hours_boat, hours_car: @checklist.hours_car, hours_foot: @checklist.hours_foot, hours_owling: @checklist.hours_owling, hours_total: @checklist.hours_total, location: @checklist.location, max_parties: @checklist.max_parties, miles_boat: @checklist.miles_boat, miles_car: @checklist.miles_car, miles_foot: @checklist.miles_foot, miles_owling: @checklist.miles_owling, miles_total: @checklist.miles_total, min_parties: @checklist.min_parties, sector_id: @checklist.sector_id, start_time: @checklist.start_time, survey_id: @checklist.survey_id, observations_attributes: { "0": { id: "", number: "", count_week: 0, taxon_id: 1 } } }
    end

    assert_redirected_to checklist_path(assigns(:checklist))
  end

  test "should show checklist" do
    get :show, id: @checklist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @checklist
    assert_response :success
  end

  test "should update checklist" do
    patch :update, id: @checklist, checklist: { area_id: @checklist.area_id, end_time: @checklist.end_time, feeder_watch: @checklist.feeder_watch, hours_boat: @checklist.hours_boat, hours_car: @checklist.hours_car, hours_foot: @checklist.hours_foot, hours_owling: @checklist.hours_owling, hours_total: @checklist.hours_total, location: @checklist.location, max_parties: @checklist.max_parties, miles_boat: @checklist.miles_boat, miles_car: @checklist.miles_car, miles_foot: @checklist.miles_foot, miles_owling: @checklist.miles_owling, miles_total: @checklist.miles_total, min_parties: @checklist.min_parties, sector_id: @checklist.sector_id, start_time: @checklist.start_time, survey_id: @checklist.survey_id, observations_attributes: { "0": { id: "", number: "", count_week: 0, taxon_id: 1 } } }
    assert_redirected_to checklist_path(assigns(:checklist))
  end

  test "should destroy checklist" do
    assert_difference("Checklist.count", -1) do
      delete :destroy, id: @checklist
    end

    assert_redirected_to checklists_path
  end
end
