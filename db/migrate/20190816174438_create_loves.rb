class CreateLoves < ActiveRecord::Migration[5.1]
  def change
    create_table :loves do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
