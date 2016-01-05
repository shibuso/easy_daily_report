class AddStatusToReportsAndWorks < ActiveRecord::Migration
  def change
    add_column :reports, :status, :integer, null: false, default: 0
    add_column :works, :status, :integer, null: false, default: 0
  end
end
