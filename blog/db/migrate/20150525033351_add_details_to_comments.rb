class AddDetailsToComments < ActiveRecord::Migration
  def change
    change_column_null :comments, :commenter, false
    change_column_null :comments, :body, false
  end
end
