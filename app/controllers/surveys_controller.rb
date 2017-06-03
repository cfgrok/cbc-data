class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.all
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    @surveys = Survey.joins(:year).order('years.audubon_year DESC')
    @observations = Observation.joins(:taxon, :checklist => [survey: :year])
      .includes(:taxon, :checklist => [survey: :year])
      .where('checklists.survey_id IN (?)', @surveys.to_a)
      .order('taxons.taxonomic_order, years.audubon_year DESC')
    @surveys_data = @observations.map do |observation|
      [observation.taxon.id,
       observation.checklist.survey.to_s,
       observation.number && !observation.count_week ? observation.number : 'Count Week']
    end.reduce({}) do |list, observation|
      taxon, survey, number = observation

      list[taxon] ||= {}
      if !list[taxon].key? survey
        list[taxon][survey] ||= number
      elsif number != 'Count Week'
        list[taxon][survey] = 0 if list[taxon][survey] == 'Count Week'
        list[taxon][survey] += number
      end

      list
    end

    selected_year = @survey.to_s
    hist_years = @surveys.map {|s| s.to_s}.reject {|s| s >= selected_year}

    survey_totals = @surveys.reduce({}) do |list, survey|
      list[survey.to_s] = [survey.species_total, survey.individual_total]
      list
    end

    all_species_totals = survey_totals.map {|t| t.last.first}
    all_individual_totals = survey_totals.map {|t| t.last.last}

    @all_species_avg = (all_species_totals.sum.to_f / @surveys.size).round
    @all_individual_avg = (all_individual_totals.sum.to_f / @surveys.size).round

    hist_survey_totals = survey_totals.reject {|k, v| k >= selected_year}
    hist_species_totals = hist_survey_totals.map {|t| t.last.first}
    hist_individual_totals = hist_survey_totals.map {|t| t.last.last}

    unless hist_years.empty?
      @hist_species_avg = (hist_species_totals.sum.to_f / hist_years.size).round
      @hist_individual_avg = (hist_individual_totals.sum.to_f / hist_years.size).round

      @species_percent_change = (@survey.species_total.to_f / @hist_species_avg - 1) * 100
      @individual_percent_change = (@survey.individual_total.to_f / @hist_individual_avg - 1) * 100

      @species_change_style = @species_percent_change < 0 ? "red" : ""
      @individual_change_style = @individual_percent_change < 0 ? "red" : ""
    else
      @hist_species_avg = ""
      @hist_individual_avg = ""

      @species_percent_change = nil
      @individual_percent_change = nil

      @species_change_style = ""
      @individual_change_style = ""
    end

    @species_high = all_species_totals.max
    @species_low = all_species_totals.min

    @species_high_style = @survey.species_total == @species_high ? "red" : ""
    @species_low_style = @survey.species_total == @species_low ? "red" : ""

    @individual_high = all_individual_totals.max
    @individual_low = all_individual_totals.min

    @individual_high_style = @survey.individual_total == @individual_high ? "red" : ""
    @individual_low_style = @survey.individual_total == @individual_low ? "red" : ""

    @surveys_data.each do |taxon_observations|
      observations = taxon_observations.last

      all_years = observations.size
      counts = observations.values.reject {|v| v == "Count Week"}
      counted_years = counts.size
      all_avg = counts.empty? ? "" : (counts.sum.to_f / @surveys.size).round(1)

      selected_count = observations.fetch(selected_year, "")

      high = counts.max
      low = counts.min
      high_style = high && selected_count.to_i >= high ? "bold" : ""
      low_style = low && selected_count != "" && selected_count.to_i <= low && low != high ? "bold red" : ""

      hist_observations = observations.reject {|k, v| k >= selected_year}
      hist_counts = hist_observations.values.reject {|v| v == "Count Week"}
      hist_avg = hist_counts.empty? ? "" : (hist_counts.sum.to_f / hist_years.size).round(1)

      change_style = ""
      if hist_avg == "" || selected_count == "" || selected_count == "Count Week"
        percent_change = nil
      else
        percent_change = (selected_count / hist_avg - 1) * 100
        change_style = "red" if percent_change < 0
      end

      taxon_observations.last.merge!(
        { "all_years" => all_years,
          "counted_years" => counted_years,
          "all_avg" => all_avg,
          "high" => high,
          "low" => low,
          "high_style" => high_style,
          "low_style" => low_style,
          "hist_avg" => hist_avg,
          "percent_change" => percent_change,
          "change_style" => change_style }
      )

    end
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:date, :year_id)
    end
end
