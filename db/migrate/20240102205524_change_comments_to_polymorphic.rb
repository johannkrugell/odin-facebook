class ChangeCommentsToPolymorphic < ActiveRecord::Migration[7.1]
  def change
    remove_reference :comments, :post, index: true, foreign_key: true
    add_reference :comments, :commentable, polymorphic: true, index: true
  end
end
