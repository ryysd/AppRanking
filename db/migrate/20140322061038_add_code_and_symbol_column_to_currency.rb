class AddCodeAndSymbolColumnToCurrency < ActiveRecord::Migration
  def change
      add_column :currencies, :code, :string, :limit=>16
      add_column :currencies, :symbol, :string, :limit=>16
      change_column :currencies, :name, :string, :limit=>32
  end
end
