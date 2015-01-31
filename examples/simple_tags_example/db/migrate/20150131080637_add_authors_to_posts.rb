class AddAuthorsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :authors, :string, array: true, default: '{}'
    add_index :posts, :authors, using: 'gin'
  end
end
