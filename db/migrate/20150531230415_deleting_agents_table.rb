class DeletingAgentsTable < ActiveRecord::Migration
  def change
    drop_table :agents
  end
end
