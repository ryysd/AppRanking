class CreateScreenShots < ActiveRecord::Migration
  def change
    create_table :screen_shots do |t|

      t.timestamps
    end
  end
end
