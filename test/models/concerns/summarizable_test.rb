# frozen_string_literal: true

require "test_helper"

class SummarizableTest < ActiveSupport::TestCase
  test "species total of zero" do
    summarizable = create_summarizable

    assert_equal 0, summarizable.observations.length
    assert_equal 0, summarizable.species_total, "Species total not zero with no observations"

    observation1 = observations(:cang)
    summarizable.observations << observation1

    assert_equal 1, summarizable.observations.length
    assert_equal 0, summarizable.species_total, "Species total not zero with one observation without a number"

    observation1.count_week = true

    assert_equal 0, summarizable.species_total, "Species total not zero with one count week observation"

    observation1.count_week = nil
    observation1.number = 0

    assert_equal 0, summarizable.species_total, "Species total not zero with one observation with a number of zero"

    observation2 = observations(:olgu)
    observation2.number = 1
    summarizable.observations << observation2

    assert_equal 2, summarizable.observations.length
    assert_equal 0, summarizable.species_total, "Species total not zero with ignored hybrid observation"

    observation3 = observations(:spuh)
    observation3.number = 1
    summarizable.observations << observation3

    assert_equal 3, summarizable.observations.length
    assert_equal 0, summarizable.species_total, "Species total not zero with ignored \"spuh\" observation"
  end

  test "species total of one" do
    summarizable = create_summarizable
    observation1 = observations(:cang)
    observation1.number = 1
    summarizable.observations << observation1

    assert_equal 1, summarizable.observations.length
    assert_equal 1, summarizable.species_total, "Species total not one with one observation"

    observation2 = observations(:doma)
    observation2.number = 1
    summarizable.observations << observation2

    assert_equal 2, summarizable.observations.length
    assert_equal 1, summarizable.species_total, "Species total not one with domestic species observation added"

    observation3 = observations(:nofl)
    observation3.count_week = true
    summarizable.observations << observation3

    assert_equal 3, summarizable.observations.length
    assert_equal 1, summarizable.species_total, "Species total not one with count week observation added"
  end

  test "species total with multiple species forms" do
    summarizable = create_summarizable

    observation1 = observations(:cang)
    observation1.number = 1
    summarizable.observations << observation1

    observation2 = observations(:doma)
    observation2.number = 1
    summarizable.observations << observation2

    observation3 = observations(:baea)
    observation3.number = 2
    summarizable.observations << observation3

    observation4 = observations(:nofl)
    observation4.number = 3
    summarizable.observations << observation4

    observation5 = observations(:deju)
    observation5.number = 4
    summarizable.observations << observation5

    assert_equal 5, summarizable.observations.length
    assert_equal 4, summarizable.species_total, "Species total not accurate with multiple observations"

    observation6 = observations(:baea_i)
    observation6.number = 2
    summarizable.observations << observation6

    observation7 = observations(:nofl_ys)
    observation7.number = 3
    summarizable.observations << observation7

    observation8 = observations(:nofl_in)
    observation8.number = 3
    summarizable.observations << observation8

    observation9 = observations(:deju_sc)
    observation9.number = 4
    summarizable.observations << observation9

    assert_equal 9, summarizable.observations.length
    assert_equal 4, summarizable.species_total, "Species total not accurate with duplicate observations"

    observation10 = observations(:cacg_cang)
    observation10.number = 1
    summarizable.observations << observation10

    assert_equal 10, summarizable.observations.length
    assert_equal 4, summarizable.species_total, "Species total not accurate with slash observation"
  end

  test "count week total" do
    summarizable = create_summarizable

    observation1 = observations(:cang)
    observation1.count_week = true
    summarizable.observations << observation1

    observation2 = observations(:doma)
    observation2.count_week = true
    summarizable.observations << observation2

    observation3 = observations(:baea)
    observation3.count_week = true
    summarizable.observations << observation3

    observation4 = observations(:nofl)
    observation4.count_week = true
    summarizable.observations << observation4

    observation5 = observations(:deju)
    observation5.count_week = true
    summarizable.observations << observation5

    assert_equal 5, summarizable.observations.length
    assert_equal 4, summarizable.count_week_total, "Count week total not accurate with multiple observations"

    observation6 = observations(:baea_i)
    observation6.count_week = true
    summarizable.observations << observation6

    observation7 = observations(:nofl_ys)
    observation7.count_week = true
    summarizable.observations << observation7

    observation8 = observations(:nofl_in)
    observation8.count_week = true
    summarizable.observations << observation8

    observation9 = observations(:deju_sc)
    observation9.count_week = true
    summarizable.observations << observation9

    assert_equal 9, summarizable.observations.length
    assert_equal 4, summarizable.count_week_total, "Count week total not accurate with duplicate observations"

    observation10 = observations(:cacg_cang)
    observation10.count_week = true
    summarizable.observations << observation10

    assert_equal 10, summarizable.observations.length
    assert_equal 4, summarizable.count_week_total, "Count week total not accurate with slash observation"

    observation11 = observations(:cang)
    observation11.number = 1
    summarizable.observations << observation11

    assert_equal 11, summarizable.observations.length
    assert_equal 3, summarizable.count_week_total, "Count week total not accurate with duplicate species observation"

    observation12 = observations(:deju_sc)
    observation12.number = 1
    summarizable.observations << observation12

    assert_equal 12, summarizable.observations.length
    assert_equal 2, summarizable.count_week_total, "Count week total not accurate with duplicate species observation"
  end

  private

  def create_summarizable
    SummarizableObject.new
  end
end

class SummarizableObject
  include Summarizable

  attr_accessor :observations

  def initialize
    @observations = []
  end
end
