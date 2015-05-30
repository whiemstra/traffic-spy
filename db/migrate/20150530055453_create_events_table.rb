class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table "events", force: :cascade do |t|
      t.text "name"
    end
  end
end
