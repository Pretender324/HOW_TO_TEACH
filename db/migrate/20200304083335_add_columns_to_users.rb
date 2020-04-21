class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :image, :string
    add_column :users, :status, :string
    add_column :users, :subject, :string
    add_column :users, :name, :string
  end
end
