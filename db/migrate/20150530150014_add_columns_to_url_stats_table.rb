class AddColumnsToUrlStatsTable < ActiveRecord::Migration
  def change
    add_column :url_stats,  :user_agent,   :text
    add_column :url_stats,  :http_verb,    :text
    add_column :url_stats,  :referred_by,  :text
  end
end
