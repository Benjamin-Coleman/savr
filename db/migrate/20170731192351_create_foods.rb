class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :quantity
      t.string :cuisine
      t.integer :listing_id
      t.string :type

      t.timestamps
    end
  end
end
