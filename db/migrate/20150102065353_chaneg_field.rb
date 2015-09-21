class ChanegField < ActiveRecord::Migration
  def up
  	remove_column :messages, :number
  	add_column :messages, :number, :string
  end

  def down
  end
end
