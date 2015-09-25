class Work < ActiveRecord::Base
  belongs_to :report
  belongs_to :project

  validates :project_id, presence: true
  validates :time, numericality: { greater_than_or_equal_to: 0 }

  #TODO report_idのvalidation
end
