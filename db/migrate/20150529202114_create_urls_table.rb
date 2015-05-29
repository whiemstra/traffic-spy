class CreateUrlsTable < ActiveRecord::Migration
  def change
    create_table :urls do
      t.text     :text
  end
end
