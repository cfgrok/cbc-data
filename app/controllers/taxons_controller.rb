# frozen_string_literal: true

class TaxonsController < ApplicationController
  before_action :set_taxon, only: %i[show edit update destroy]

  # GET /taxons
  # GET /taxons.json
  def index
    @taxons = Taxon.all
  end

  # GET /taxons/1
  # GET /taxons/1.json
  def show; end

  # GET /taxons/new
  def new
    @taxon = Taxon.new
  end

  # GET /taxons/1/edit
  def edit; end

  # POST /taxons
  # POST /taxons.json
  def create
    @taxon = Taxon.new(taxon_params)

    respond_to do |format|
      if @taxon.save
        format.html { redirect_to @taxon, notice: t(".success") }
        format.json { render :show, status: :created, location: @taxon }
      else
        format.html { render :new }
        format.json { render json: @taxon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /taxons/1
  # PATCH/PUT /taxons/1.json
  def update
    respond_to do |format|
      if @taxon.update(taxon_params)
        format.html { redirect_to @taxon, notice: t(".success") }
        format.json { render :show, status: :ok, location: @taxon }
      else
        format.html { render :edit }
        format.json { render json: @taxon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taxons/1
  # DELETE /taxons/1.json
  def destroy
    @taxon.destroy
    respond_to do |format|
      format.html { redirect_to taxons_url, notice: t(".success") }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_taxon
    @taxon = Taxon.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def taxon_params
    params.require(:taxon).permit(:common_name, :cbc_name, :scientific_name, :taxonomic_order, :generic, :active)
  end
end
