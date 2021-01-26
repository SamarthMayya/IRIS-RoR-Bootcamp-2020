class AddAuthorisationToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :user_id, :integer
    add_column :articles, :public, :boolean, default: false 
  end
end
