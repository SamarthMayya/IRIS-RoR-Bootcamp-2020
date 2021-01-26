class AddFieldsToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :title, :string
    add_column :articles, :topic, :string
    add_column :articles, :tags, :string
  end
end
