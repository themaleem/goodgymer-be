class CreatePairings < ActiveRecord::Migration[7.1]
  def change
    create_table :pairings do |t|
      t.integer :session_id
      t.integer :goodgymer_id

      t.timestamps
    end
    add_index :pairings, %i[goodgymer_id session_id], unique: true
  end
end
