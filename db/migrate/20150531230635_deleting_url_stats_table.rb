class DeletingUrlStatsTable < ActiveRecord::Migration
  def change
    drop_table :url_stats
  end
end
