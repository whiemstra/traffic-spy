class DeletingApplicationDetailsTable < ActiveRecord::Migration
  def change
    drop_table :application_details
  end
end
