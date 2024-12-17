class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  has_many :campaigns, dependent: :destroy
  has_many :tasks, through: :campaigns, dependent: :destroy
  has_many :organizations, dependent: :destroy
  has_many :contacts, through: :organizations
  has_many :expenses, dependent: :destroy
  
  validates :first_name, :last_name, presence: true
end
