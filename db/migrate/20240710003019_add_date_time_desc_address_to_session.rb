class AddDateTimeDescAddressToSession < ActiveRecord::Migration[7.1]
  def change
    add_column :sessions, :date, :date
    add_column :sessions, :address, :string
    add_column :sessions, :start_time, :time
    add_column :sessions, :description, :text

    add_index :sessions, :session_id, unique: true
  end
end
