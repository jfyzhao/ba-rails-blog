class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :liked, default: 0
      t.string :user
      t.references :article, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
