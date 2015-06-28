class AddDefualtToChefs < ActiveRecord::Migration
  def change
  	change_column :chefs, :admin, :boolean, :default => false
  end
end
