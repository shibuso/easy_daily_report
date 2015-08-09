class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user, null: false
      t.date :target_date, null: false
      t.text :question
      t.text :impression

      t.timestamps null: false
    end
    add_index :reports, :user_id
  end
end
