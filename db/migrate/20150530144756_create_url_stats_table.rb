class CreateUrlStatsTable < ActiveRecord::Migration
  def change
    create_table :url_stats do |t|
      t.integer     :response_time
    end
  end
end
