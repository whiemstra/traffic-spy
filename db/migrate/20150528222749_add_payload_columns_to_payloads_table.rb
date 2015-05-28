class AddPayloadColumnsToPayloadsTable < ActiveRecord::Migration
  def change
    add_column :payloads, :requested_at,      :datetime
    add_column :payloads, :responded_in,      :integer
    add_column :payloads, :referred_by,       :text
    add_column :payloads, :request_type,      :text
    add_column :payloads, :event_name,        :text
    add_column :payloads, :user_agent,        :text
    add_column :payloads, :resolution_width,  :integer
    add_column :payloads, :resolution_height, :integer
  end
end
