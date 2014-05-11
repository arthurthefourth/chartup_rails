class CreateUsabilitySurveys < ActiveRecord::Migration
  def change
    create_table :usability_surveys do |t|
      t.integer :user_id
      t.boolean :useful_now
      t.boolean :useful_eventually
      t.string :app_version

      t.timestamps
    end
  end
end
