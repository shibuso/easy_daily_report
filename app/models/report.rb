class Report < ActiveRecord::Base
  has_many :works, dependent: :destroy
  accepts_nested_attributes_for :works, reject_if: :all_blank, allow_destroy: true

  belongs_to :user

  validates :user_id, :target_date, :status, presence: true
  validates :status, inclusion: Settings.report.status_types.values

  scope :order_update_newest, -> { order('updated_at DESC') }
  scope :draft, -> { where(status: Settings.report.status_types.draft) }
  scope :published, -> { where(status: Settings.report.status_types.published) }

  after_save :update_works_status, if: lambda { self.status == Settings.report.status_types.published }

  def update_works_status
    self.works.each do |work|
      work.status = Settings.work.status_types.published
      work.save
    end
  end
end
