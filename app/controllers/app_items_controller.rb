class AppItemsController < ApplicationController
  before_action :set_app_item, only: [:show, :edit, :update, :destroy]

  # GET /app_items
  # GET /app_items.json
  def index
  end

  # GET /app_items/1
  # GET /app_items/1.json
  def show
  end

  # GET /app_items/new
  def new
    @app_item = AppItem.new
  end

  # GET /app_items/1/edit
  def edit
  end

  # POST /app_items
  # POST /app_items.json
  def create
    @app_item = AppItem.new(app_item_params)

    respond_to do |format|
      if @app_item.save
        format.html { redirect_to @app_item, notice: 'App item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @app_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @app_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_items/1
  # PATCH/PUT /app_items/1.json
  def update
    respond_to do |format|
      if @app_item.update(app_item_params)
        format.html { redirect_to @app_item, notice: 'App item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @app_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_items/1
  # DELETE /app_items/1.json
  def destroy
    @app_item.destroy
    respond_to do |format|
      format.html { redirect_to app_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_item
      @app_item = AppItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_item_params
      params[:app_item]
    end
end
