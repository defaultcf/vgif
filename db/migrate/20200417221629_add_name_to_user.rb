# frozen_string_literal: true

class AddNameToUser < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :username, :string, null: false, default: ''
    add_column :users, :displayname, :string, null: false, default: ''

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

  def down
    remove_column :users, :username
    remove_column :users, :displayname
  end
end
