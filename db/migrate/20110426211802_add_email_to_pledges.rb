class AddEmailToPledges < ActiveRecord::Migration
  def self.up
    add_column :pledges, :email, :string
  end

  def self.down
    remove_column :pledges, :email
  end
end