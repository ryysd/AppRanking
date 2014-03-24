require 'spec_helper'

describe AppItem do
  pending "add some examples to (or delete) #{__FILE__}"

  before do
    @market_gp = Market.find_by_code 'GP'
    @country_ja = Country.find_by_code 'JP'
    @feed_topfree = Feed.find_by_code 'topselling_free'
    @category_game = Category.find_by_name 'Games'
  end

  context 'when local_id is invalid' do
    describe 'load_google_play()' do
      it 'raise error' do
      end
    end
    describe 'load_itunes_connect()' do
      it 'raise error' do
      end
    end
  end

  context 'when local_id is valid' do
    before do
      @app_jp_gp = AppItem.new country: @country_ja, market: @market_gp 
    end

    describe 'assign_category()' do
      context 'with valid google play category name' do
	it 'should assign valid category' do
	  Category.all.each do |category|
	    @app_jp_gp.send :assign_category, category.name
	    expect(@app_jp_gp.category.name).to eq(category.name)
	  end
	end
      end
      context 'with valid itunes connect category name' do
	it 'should assign valid category' do
	  # not implemented
	end
      end
      context 'with invalid category name' do
	it 'raise error' do
	  # not implemented
	end
      end
    end

    describe 'add_or_update_price()' do
      context 'with new price' do
	it 'should add price correctly' do
          @app_jp_gp.send :add_or_update_price, 2.00
	  expect(@app_jp_gp.prices.length).to eq(1)
	  expect(@app_jp_gp.prices.first.value).to eq(200)
	end
      end

      context 'with overlapped price' do
	it 'should update price correctly' do
          @app_jp_gp.send :add_or_update_price, 2.00
          @app_jp_gp.send :add_or_update_price, 5.00
	  expect(@app_jp_gp.prices.length).to eq(1)
	  expect(@app_jp_gp.prices.first.value).to eq(500)
	end
      end
    end

    describe 'add_or_update_description' do
      context 'with new description' do
	it 'should add description correctly' do
	  @app_jp_gp.send :add_or_update_description, 'desc'
	  expect(@app_jp_gp.descriptions.length).to eq(1)
	  expect(@app_jp_gp.descriptions.first.text).to eq('desc')
	end
      end

      context 'with overlapped description' do
	it 'should update description correctly' do
	  @app_jp_gp.send :add_or_update_description, 'desc_before'
	  @app_jp_gp.send :add_or_update_description, 'desc_after'
	  expect(@app_jp_gp.descriptions.length).to eq(1)
	  expect(@app_jp_gp.descriptions.first.text).to eq('desc_after')
	end
      end
    end
  end
end
