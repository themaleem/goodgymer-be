class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.string :name
      t.string :area_id
      t.string :session_id
      t.integer :created_by
      t.integer :session_type
      t.bigint :registration_limit

      t.timestamps
    end

    add_index :sessions, %i[session_type]
    add_index :sessions, %i[created_by]
  end
end
