class CreateGoodgymers < ActiveRecord::Migration[7.1]
  def change
    create_table :goodgymers do |t|
      t.integer :role
      t.string :area_id
      t.integer :user_id

      t.timestamps
    end
  end
end
