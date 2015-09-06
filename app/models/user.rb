class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects_users
  has_many :projects, through: :projects_users

  validates :name, :user_type, presence: true

  def admin?
    self.user_type == Settings.user_types.admin
  end

  def member?
    self.user_type == Settings.user_types.member
  end

  def partner?
    self.user_type == Settings.user_types.partner
  end

end
