class AddSentFlagToPledges < ActiveRecord::Migration
  def self.up
    add_column :pledges, :sent, :boolean
  end

  def self.down
    remove_column :pledges, :sent
  end
end