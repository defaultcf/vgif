# frozen_string_literal: true

class AddNameToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :username, null: false, default: ''
      t.string :displayname, null: false, default: ''
    end

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE users
          SET
            username = mapping.new_username,
            displayname = mapping.new_username
          FROM (
            SELECT
              id AS new_username
            FROM users
          ) AS mapping
          WHERE users.id = mapping.new_username;
        SQL
      end
    end
  end
end
