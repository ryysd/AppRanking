require 'spec_helper'

describe Ranking do
  pending "add some examples to (or delete) #{__FILE__}"

  before do
    @ranking_jp_gp_topfree_game = Ranking.new country_code: 'JP', feed_code: 'topselling_free', category_code: 'game', market_code: 'GP'
  end

  context 'when country_code, feed_code and category_code are valid' do
    describe 'load_apps_google_play()' do
      it 'should return valid ranking data' do
	apps = @ranking_jp_gp_topfree_game.send :load_apps_google_play

	expect(apps.length).to be > 0
      end
    end

    describe 'add_or_update_apps()' do
      context 'with new app' do
	it 'should add new app correctly' do
	  apps = @ranking_jp_gp_topfree_game.send :load_apps_google_play
	  
	  @ranking_jp_gp_topfree_game.send :add_or_update_app, apps.first
	  
	  expect(@ranking_jp_gp_topfree_game.app_items.length).to eq(1)
	end
      end

      context 'with overlapped new app (updated in 60min)' do
	it 'should not update app (not implemented)' do
	end
      end

      context 'with overlapped old app (not updated over 60min)' do
	it 'should update app correctly (not implemented)' do
	end
      end
    end
  end
end
