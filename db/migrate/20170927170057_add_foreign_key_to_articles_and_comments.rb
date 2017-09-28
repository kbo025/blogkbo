class AddForeignKeyToArticlesAndComments < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :articles, :users
    add_foreign_key :comments, :users
  end
end
