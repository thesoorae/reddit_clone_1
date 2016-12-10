class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :author_id
      t.text :content, null: false
      t.integer :post_id
      t.integer :parent_comment_id

      t.timestamps null: false
    end
    add_index :comments, :author_id, :post_id, :parent_comment_id
  end
end
