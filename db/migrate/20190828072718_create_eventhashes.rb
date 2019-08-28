class CreateEventhashes < ActiveRecord::Migration[5.1]
  def change
    create_table :eventhashes do |t|
      t.references :event, foreign_key: true
      t.references :hash_tag, foreign_key: true

      t.timestamps
    end
  end
end
