class RenamingPayhashColumnInPayloadsTable < ActiveRecord::Migration
  def change
    rename_column :payloads, :payhash, :fingerprint
  end
end
