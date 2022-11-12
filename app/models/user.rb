class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
    
  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :phone_number
  validates :username, uniqueness: true, presence: true, format: { with: /\A[a-zA-Z]+([a-zA-Z]|\d)*\Z/ }
  validates :phone_number, format: { with: /\A\d{10}\z|\A\d{4}-{1}\d{6}\z/ , message: "bad format" }
end
