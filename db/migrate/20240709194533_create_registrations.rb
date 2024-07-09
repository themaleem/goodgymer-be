class CreateRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :registrations do |t|
      t.integer :goodgymer_id
      t.integer :session_id

      t.timestamps
    end

    add_index :registrations, %i[goodgymer_id session_id], unique: true
  end
end
