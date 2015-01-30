class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :tags, array: true, default: '{}'
      t.timestamps
    end
    add_index :posts, :tags, using: 'gin'
  end
end
