class CreateOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :email
      t.string :pay_type

      t.timestamps
    end
  end

  def down
    drop_table :orders
  end
end
