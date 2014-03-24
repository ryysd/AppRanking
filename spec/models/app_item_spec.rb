require 'spec_helper'

describe AppItem do
  pending "add some examples to (or delete) #{__FILE__}"

  before do
    @market_gp = Market.find_by_code 'GP'
    @market_itc = Market.find_by_code 'ITC'
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
      @app_jp_itc = AppItem.new country: @country_ja, market: @market_itc
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

    describe 'add_or_update_device' do
      context 'with new device' do
	it 'should add device correctly' do
	  @app_jp_gp.send :add_or_update_device, 'android'
	  expect(@app_jp_gp.devices.length).to eq(1)
	  expect(@app_jp_gp.devices.first.name).to eq('android')
	end
      end

      context 'with overlapped device' do
	it 'should update device correctly' do
	  @app_jp_itc.send :add_or_update_device, 'iPhone'
	  @app_jp_itc.send :add_or_update_device, 'iPhone'
	  expect(@app_jp_itc.devices.length).to eq(1)
	  expect(@app_jp_itc.devices.first.name).to eq('iPhone')
	end
      end

      context 'with two different devices' do
	it 'should add device correctly' do
	  @app_jp_itc.send :add_or_update_device, 'iPhone'
	  @app_jp_itc.send :add_or_update_device, 'iPad'
	  expect(@app_jp_itc.devices.length).to eq(2)
	  expect(@app_jp_itc.devices[0].name).to eq('iPhone')
	  expect(@app_jp_itc.devices[1].name).to eq('iPad')
	end
      end

      context 'with invalid device' do
	it 'should raise error' do
	  error_msg = 'There is no such device in market. device_name: iPad, market_name: Google Play'
	  expect{@app_jp_gp.send :add_or_update_device, 'iPad'}.to raise_error(RuntimeError, error_msg)
	end
      end
    end

    describe 'add_or_update_ratings' do
      context 'with new ratings' do
	it 'should add ratings correctly' do
	  @app_jp_gp.send :add_or_update_ratings, {1 => 10, 2 => 20, 3 => 30, 4 => 40, 5 => 50}
	  ratings = Hash[@app_jp_gp.rates.map{|r| [r.value, r.count]}]
	  expect(ratings.length).to eq(5)
	  expect(ratings).to include(1 => 10)
	  expect(ratings).to include(2 => 20)
	  expect(ratings).to include(3 => 30)
	  expect(ratings).to include(4 => 40)
	  expect(ratings).to include(5 => 50)
	end
      end

      context 'with overlapped ratings' do
	it 'should update ratings correctly' do
	  @app_jp_gp.send :add_or_update_ratings, {1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5}
	  @app_jp_gp.send :add_or_update_ratings, {1 => 10, 2 => 20, 3 => 30, 4 => 40, 5 => 50}
	  ratings = Hash[@app_jp_gp.rates.map{|r| [r.value, r.count]}]
	  expect(ratings.length).to eq(5)
	  expect(ratings).to include(1 => 10)
	  expect(ratings).to include(2 => 20)
	  expect(ratings).to include(3 => 30)
	  expect(ratings).to include(4 => 40)
	  expect(ratings).to include(5 => 50)
	end
      end
    end

    describe 'new_or_update_publisher' do
      context 'with new publisher' do
	it 'should save publisher correctly' do
	  @app_jp_gp.send :new_or_update_publisher, 'Publisher'
	  expect(Publisher.all.length).to eq(1)
	  expect(Publisher.all.first.name).to eq('Publisher')
	  expect(@app_jp_gp.publisher.name).to eq('Publisher')
	end
      end

      context 'with overlapped publisher' do
	it 'should associate publisher with app_item correctly' do
	  @app_jp_gp.send :new_or_update_publisher, 'Publisher'
	  @app_jp_gp.send :new_or_update_publisher, 'Publisher'
	  expect(@app_jp_gp.publisher.name).to eq('Publisher')
	end
      end
    end
  end
end
