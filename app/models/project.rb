class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :projects_users
  has_many :users, through: :projects_users
  has_many :works

  validates :name, :customer_id, :status, presence: true

  scope :active, -> { where(status: Settings.project.status_types.active) }

  def name_with_customer
    "#{customer.name}/#{name}"
  end
end
