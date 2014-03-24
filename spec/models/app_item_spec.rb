require 'spec_helper'

describe AppItem do
  pending "add some examples to (or delete) #{__FILE__}"

  before :each do
    load "#{Rails.root}/db/seeds.rb" 
  end

  context 'when local_id is invalid' do
    before do
      @invalid_app = AppItem.new local_id: 'invalidinvalid'
    end

    describe 'save method' do
      it 'raise error' do
	expect {@invalid_app.save}.to raise_error(NoMethodError)
      end
    end
  end

  context 'when local_id is valid' do
    before do
      @ja_app = AppItem.new local_id: 'com.bluefroggaming.popdat'
    end

    describe 'save method' do
      it 'should have fields with correct value' do
	@ja_app.save

	expect(@ja_app.name).to eq('Pop Dat')
	expect(@ja_app.publisher.name).to eq('Blue Frog Gaming')
	expect(@ja_app.prices.country.code).to eq('JP')
	# etc...
      end
    end
  end
end
