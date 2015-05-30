class AddTableEventDetails < ActiveRecord::Migration
  def change
    create_table :event_details do |t|
      t.text     :event_name
    end
  end
end
