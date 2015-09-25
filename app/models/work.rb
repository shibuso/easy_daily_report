class Work < ActiveRecord::Base
  belongs_to :report
  belongs_to :project

  validates :project_id, presence: true
  validates :time, numericality: { greater_than_or_equal_to: 0 }

  before_save :validate_report_id

  private

  def validate_report_id
    errors.add(:report_id, '日報を指定してください') if report_id.blank?
  end

end
