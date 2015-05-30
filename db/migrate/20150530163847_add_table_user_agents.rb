class AddTableUserAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.text     :text
    end
  end
end
