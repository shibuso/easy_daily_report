class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.references :report, null: false
      t.references :project, null: false
      t.float :time
      t.text :detail

      t.timestamps null: false
    end
    add_index :works, :report_id
    add_index :works, :project_id
  end
end
