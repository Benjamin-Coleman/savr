class CreateBids < ActiveRecord::Migration[5.1]
  def change
    create_table :bids do |t|
      t.integer :listing_id
      t.integer :receiver_id
      t.boolean :completed, :default => false

      t.timestamps
    end
  end
end
