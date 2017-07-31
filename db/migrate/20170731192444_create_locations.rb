class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code

      t.timestamps
    end
  end
end
