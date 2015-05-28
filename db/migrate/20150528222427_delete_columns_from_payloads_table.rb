class DeleteColumnsFromPayloadsTable < ActiveRecord::Migration
  def change
    remove_column :payloads, :requestedat,      :datetime
    remove_column :payloads, :respondedin,      :integer
    remove_column :payloads, :referredby,       :text
    remove_column :payloads, :requesttype,      :text
    remove_column :payloads, :eventname,        :text
    remove_column :payloads, :useragent,        :text
    remove_column :payloads, :resolutionwidth,  :integer
    remove_column :payloads, :resolutionheight, :integer
  end
end
