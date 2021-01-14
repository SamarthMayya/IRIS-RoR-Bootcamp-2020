class AddFieldsToStudents < ActiveRecord::Migration[6.1]
  def change
    add_column :students, :branch, :string
    add_column :students, :cgpa, :decimal, precision:4, scale: 2
    add_column :students, :address, :text
    add_column :students, :admission_year, :integer
  end
end
