class AddCommentToSiteComments < ActiveRecord::Migration
  def change
    add_column :site_comments, :comment, :text
  end
end
