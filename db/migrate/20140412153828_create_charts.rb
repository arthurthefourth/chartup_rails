class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.text :chartup

      t.timestamps
    end
  end
end
