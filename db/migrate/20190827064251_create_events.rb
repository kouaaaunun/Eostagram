class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :content
      t.string :hashtag
      t.string :string
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
