class ChangeIpColumn < ActiveRecord::Migration
  def change
    change_column :payloads, :ip, :string
  end
end
