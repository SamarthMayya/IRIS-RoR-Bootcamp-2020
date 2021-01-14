class RemoveFieldNameFromTableName < ActiveRecord::Migration[6.1]
  def change
    remove_column :students, :branch, :string
  end
end
