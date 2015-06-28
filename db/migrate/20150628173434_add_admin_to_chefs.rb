class AddAdminToChefs < ActiveRecord::Migration
  def change
    add_column :chefs, :admin, :boolean
  end
end
