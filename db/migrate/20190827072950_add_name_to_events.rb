class AddNameToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :name, :integer
  end
end
