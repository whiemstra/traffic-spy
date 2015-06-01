class DeletingEventDetailsTable < ActiveRecord::Migration
  def change
    drop_table :event_details
  end
end
