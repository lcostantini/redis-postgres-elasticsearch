class CreatesPgPosts < ActiveRecord::Migration
  def change
    create_table :pg_posts do |t|
      t.string :author
      t.string :title
      t.string :abstract
      t.string :content
      t.integer :likes
      t.integer :views
      t.integer :shares
    end
  end
end
