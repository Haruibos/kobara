class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :recipe_id
      t.text :direction

      t.timestamps
    end
  end
end
