class ChangingUrlsTableToApplicationDetailsTable < ActiveRecord::Migration
  def change
    drop_table :urls
  end
end
