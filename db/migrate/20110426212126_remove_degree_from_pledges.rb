class RemoveDegreeFromPledges < ActiveRecord::Migration
  def self.up
    remove_column :pledges, :degree
  end

  def self.down
    add_column :pledges, :degree, :string
  end
end
