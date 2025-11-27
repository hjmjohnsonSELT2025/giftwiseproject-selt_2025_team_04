class CreateGiftComments < ActiveRecord::Migration[7.1]
  def change
    create_table :gift_comments do |t|
      t.references :user, null: false, foreign_key: true# a comment must belong to a user
      t.text :content # what the user wrote
      t.references :gift, null: false, foreign_key: true# users leave comments on the gift page

      # in case we want to do "comment threads" with nested levels, comments can reference other comments
      # to which they belong; thread will just reference the highest level comment
      t.references :parent, null: true, foreign_key: { to_table: :gift_comments }
      t.integer :thread

      t.timestamps
    end
  end
end
