class CreateLineItems < ActiveRecord::Migration
  def up
    create_table :line_items do |t|
      t.references :product, index: true
      t.belongs_to :cart, index: true

      t.timestamps
    end
  end

  def down
    drop_table :line_items
  end
end
