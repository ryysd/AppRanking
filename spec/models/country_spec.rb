require 'spec_helper'

describe Country do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'own_country?' do
    context 'when country is own' do
      it 'should return true' do
	country = Country.find_by_code 'JP'
	expect(country.own?).to eq(true)
      end
    end

    context 'when country is not own' do
      it 'should return false' do
	country = Country.find_by_code 'US'
	expect(country.own?).to eq(false)
      end
    end
  end
end
