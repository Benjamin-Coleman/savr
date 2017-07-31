class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :score
      t.string :comment
      t.integer :user_id
      t.integer :listing_id

      t.timestamps
    end
  end
end
