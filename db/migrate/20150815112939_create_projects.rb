class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.references :customer, null: false
      t.string :status, null: false, default: 'active'

      t.timestamps null: false
    end
    add_index :projects, :customer_id
  end
end
