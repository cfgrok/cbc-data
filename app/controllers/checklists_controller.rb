class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]

  # GET /checklists
  # GET /checklists.json
  def index
    @checklists = Checklist.all
  end

  # GET /checklists/1
  # GET /checklists/1.json
  def show
  end

  # GET /checklists/new
  def new
    @checklist = Checklist.new
  end

  # GET /checklists/1/edit
  def edit
  end

  # POST /checklists
  # POST /checklists.json
  def create
    @checklist = Checklist.new(row_params)

    respond_to do |format|
      if @checklist.save
        format.html { redirect_to @checklist, notice: 'Checklist was successfully created.' }
        format.json { render :show, status: :created, location: @checklist }
      else
        format.html { render :new }
        format.json { render json: @checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checklists/1
  # PATCH/PUT /checklists/1.json
  def update
    respond_to do |format|
      if @checklist.update(row_params)
        format.html { redirect_to @checklist, notice: 'Checklist was successfully updated.' }
        format.json { render :show, status: :ok, location: @checklist }
      else
        format.html { render :edit }
        format.json { render json: @checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checklists/1
  # DELETE /checklists/1.json
  def destroy
    @checklist.destroy
    respond_to do |format|
      format.html { redirect_to checklists_url, notice: 'Checklist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    ChecklistImport.new.import params[:file]
    flash[:notice] = 'Checklist was successfully imported.'
    redirect_to checklists_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checklist
      @checklist = Checklist.find(params[:id])
    end

    def set_checklist
      @checklist = Checklist.find(params[:id])
    end

    def row_params
      cp = checklist_params
      observations = cp[:observations_attributes]

      observations.each do |observation|
        observation_attrs(observations, observation)
      end

      cp
    end

    def observation_attrs(observations, observation)
      attrs = observation.last

      if attrs['number'].empty? && attrs['count_week'] == '0'
        if attrs['id'].empty?
          observations.delete observation.first
        else
          attrs['_destroy'] = true
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checklist_params
      params.require(:checklist).permit(:survey_id, :sector_id, :area_id,
        :feeder_watch, :start_time, :end_time, :hours_foot, :hours_car,
        :hours_boat, :hours_owling, :hours_total, :miles_foot, :miles_car,
        :miles_boat, :miles_owling, :miles_total, observations_attributes:
        [:id, :number, :count_week, :taxon_id, :_destroy])
    end
end