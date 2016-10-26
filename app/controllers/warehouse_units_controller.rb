class WarehouseUnitsController < ApplicationController
  before_action :set_warehouse_unit, only: [:show, :edit, :update, :destroy]

  # GET /warehouse_units
  # GET /warehouse_units.json
  def index
    @warehouse_units = WarehouseUnit.all
  end

  # GET /warehouse_units/1
  # GET /warehouse_units/1.json
  def show
  end

  # GET /warehouse_units/new
  def new
    @warehouse_unit = WarehouseUnit.new
  end

  # GET /warehouse_units/1/edit
  def edit
  end

  # POST /warehouse_units
  # POST /warehouse_units.json
  def create
    @warehouse_unit = WarehouseUnit.new(warehouse_unit_params)

    respond_to do |format|
      if @warehouse_unit.save
        format.html { redirect_to @warehouse_unit, notice: 'Warehouse unit was successfully created.' }
        format.json { render :show, status: :created, location: @warehouse_unit }
      else
        format.html { render :new }
        format.json { render json: @warehouse_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /warehouse_units/1
  # PATCH/PUT /warehouse_units/1.json
  def update
    respond_to do |format|
      if @warehouse_unit.update(warehouse_unit_params)
        format.html { redirect_to @warehouse_unit, notice: 'Warehouse unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @warehouse_unit }
      else
        format.html { render :edit }
        format.json { render json: @warehouse_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warehouse_units/1
  # DELETE /warehouse_units/1.json
  def destroy
    @warehouse_unit.destroy
    respond_to do |format|
      format.html { redirect_to warehouse_units_url, notice: 'Warehouse unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warehouse_unit
      @warehouse_unit = WarehouseUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warehouse_unit_params
      params.require(:warehouse_unit).permit(:name, :sku, :count, :status)
    end
end
