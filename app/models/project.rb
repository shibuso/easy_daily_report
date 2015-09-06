class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :projects_users
  has_many :users, through: :projects_users

  validates :name, :customer_id, :status, presence: true

end
