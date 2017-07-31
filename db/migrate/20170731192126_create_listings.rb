class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.integer :location_id
      t.string :status
      t.integer :donator_id

      t.timestamps
    end
  end
end
