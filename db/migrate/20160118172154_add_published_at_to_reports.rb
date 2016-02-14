class AddPublishedAtToReports < ActiveRecord::Migration
  def change
    add_column :reports, :published_at, :datetime
  end
end
