class Report < ActiveRecord::Base
  has_many :works, dependent: :destroy
  accepts_nested_attributes_for :works, reject_if: :all_blank, allow_destroy: true

  belongs_to :user

  validates :target_date, presence: true

  scope :order_update_newest, -> { order('updated_at DESC') }

end
