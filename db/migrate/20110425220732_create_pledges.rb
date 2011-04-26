class CreatePledges < ActiveRecord::Migration
  def self.up
    create_table :pledges, :force => true do |t|
      t.string  :name
      t.string  :degree
      t.integer :class_year
      t.integer :pledge_years
      t.text    :comments
      t.boolean :is_anonymous
      t.timestamps
    end
  end

  def self.down
    drop_table :pledges
  end
end