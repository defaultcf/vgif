class CreateGifs < ActiveRecord::Migration[6.0]
  def change
    create_table :gifs, id: :uuid do |t|
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.boolean :public, null: false, default: true

      t.timestamps
    end
  end
end
