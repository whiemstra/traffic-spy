class CreateUrlsTable < ActiveRecord::Migration
  def change
    create_table :application_details do |t|
      t.text     :text
    end
  end
end
