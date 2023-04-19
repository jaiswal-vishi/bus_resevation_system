class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:customer, :admin, :bus_owner]

  scope :bus_owners, -> { where(role: "bus_owner") }
  
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
