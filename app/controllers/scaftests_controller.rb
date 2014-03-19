class ScaftestsController < ApplicationController
  before_action :set_scaftest, only: [:show, :edit, :update, :destroy]

  # GET /scaftests
  # GET /scaftests.json
  def index
    @scaftests = Scaftest.all
  end

  # GET /scaftests/1
  # GET /scaftests/1.json
  def show
  end

  # GET /scaftests/new
  def new
    @scaftest = Scaftest.new
  end

  # GET /scaftests/1/edit
  def edit
  end

  # POST /scaftests
  # POST /scaftests.json
  def create
    @scaftest = Scaftest.new(scaftest_params)

    respond_to do |format|
      if @scaftest.save
        format.html { redirect_to @scaftest, notice: 'Scaftest was successfully created.' }
        format.json { render action: 'show', status: :created, location: @scaftest }
      else
        format.html { render action: 'new' }
        format.json { render json: @scaftest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scaftests/1
  # PATCH/PUT /scaftests/1.json
  def update
    respond_to do |format|
      if @scaftest.update(scaftest_params)
        format.html { redirect_to @scaftest, notice: 'Scaftest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @scaftest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scaftests/1
  # DELETE /scaftests/1.json
  def destroy
    @scaftest.destroy
    respond_to do |format|
      format.html { redirect_to scaftests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scaftest
      @scaftest = Scaftest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scaftest_params
      params.require(:scaftest).permit(:name, :int)
    end
end
