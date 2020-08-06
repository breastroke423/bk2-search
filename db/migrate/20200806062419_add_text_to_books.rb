class AddTextToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :text, :string
  end
end
