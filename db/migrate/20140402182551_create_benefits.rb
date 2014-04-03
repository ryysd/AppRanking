class CreateBenefits < ActiveRecord::Migration
  def change
    create_table :benefits do |t|
      t.text :description, :null => false
      t.string :image_url, :null => false, :limit => 128

      t.timestamps
    end
  end
end
