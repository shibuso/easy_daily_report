class Report < ActiveRecord::Base
  has_many :works, dependent: :destroy
  accepts_nested_attributes_for :works, reject_if: :all_blank, allow_destroy: true

  validates :target_date, presence: true

end
