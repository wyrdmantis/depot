class AddOrderToLineItem < ActiveRecord::Migration
  def up
    add_reference :line_items, :order, index: true
  end

  def down
    remove_reference :line_items, :order, index: true
  end
end
