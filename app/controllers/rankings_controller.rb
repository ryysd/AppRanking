class RankingsController < ApplicationController
  before_action :set_ranking, only: [:show, :edit, :update, :destroy]

  def search
  end

  # GET /rankings
  # GET /rankings.json
  def index
    self.debug
    @rankings = Ranking.all
  end

  # GET /rankings/1
  # GET /rankings/1.json
  def show
    @ranking = Ranking.find_by_id params[:id]
  end

  # GET /rankings/new
  def new
    @ranking = Ranking.new
  end

  # GET /rankings/1/edit
  def edit
  end

  # POST /rankings
  # POST /rankings.json
  def create
    @ranking = Ranking.new(ranking_params)

    respond_to do |format|
      if @ranking.save
        format.html { redirect_to @ranking, notice: 'Ranking was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ranking }
      else
        format.html { render action: 'new' }
        format.json { render json: @ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rankings/1
  # PATCH/PUT /rankings/1.json
  def update
    respond_to do |format|
      if @ranking.update(ranking_params)
        format.html { redirect_to @ranking, notice: 'Ranking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rankings/1
  # DELETE /rankings/1.json
  def destroy
    @ranking.destroy
    respond_to do |format|
      format.html { redirect_to rankings_url }
      format.json { head :no_content }
    end
  end

  def debug
    res = nil
    # ranking debug
    options = {:min_rank=>1, :max_rank=>24, :app_update? => true}
    rankings_params = {country_code: 'jp', market_code: 'GP', feed_code: 'topselling_free', category_code: 'game', device_name: 'android', options: options}
    # rankings_params = {country_code: 'jp', market_code: 'ITC', feed_code: 'topfreeapplications', category_code: '6014', device_name: 'iPhone', options: options}

    # rank = Ranking.new rankings_params
    # rank.save

    # res = Proxy.check_ssl host:"177.124.60.91",port:"3128"
    # res = Proxy.get_proxies_from_hidemyass

    # Country.all.select{|c| c.is_popular}.each{|c| pp "#{c.name} #{c.proxies.length}"}
    # countries = Proxy.all.map{|proxy| proxy.country}.uniq
    # countries.each{|c| pp c.name}
    # proxy debug
    # proxies = Proxy.create_ssl_proxies
    # proxies.each{|proxy| proxy.save if proxy.valid?}
    pp res
  end

  def rankings_params
    params.require(:ranking).permit(:country_code, :market_code, :feed_code, :category_code, :options, app_items_attributes: [:local_id, :name, :icon, :version, :released_on, :last_updated_on, :size, :iap])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ranking
      @ranking = Ranking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ranking_params
      params[:ranking]
    end
end
