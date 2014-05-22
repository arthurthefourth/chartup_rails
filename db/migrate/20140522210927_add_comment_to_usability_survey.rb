class AddCommentToUsabilitySurvey < ActiveRecord::Migration
  def change
    add_column :usability_surveys, :comment, :text
  end
end
