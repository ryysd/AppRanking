class CreateProxies < ActiveRecord::Migration
  def change
    create_table :proxies do |t|

      t.timestamps
    end
  end
end
