# frozen_string_literal: true

class CreateGifs < ActiveRecord::Migration[6.0]
  def change
    create_table :gifs, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :title, null: false
      t.string :source_url, null: false
      t.boolean :public, null: false, default: true

      t.timestamps
    end
  end
end
