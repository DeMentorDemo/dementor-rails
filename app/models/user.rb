class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
