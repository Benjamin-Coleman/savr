class AddDefaultValueToStatus < ActiveRecord::Migration[5.1]
  def change
  	change_column :listings, :status, :string, :default => 'open'
  end
end
