class RenameFoodTypeToCondition < ActiveRecord::Migration[5.1]
  def change
  	rename_column :foods, :type, :condition
  end
end
