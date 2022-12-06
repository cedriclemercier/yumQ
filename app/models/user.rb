class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
    
  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :phone_number
  validates :username, uniqueness: true, presence: true, format: { with: /\A[a-zA-Z]+([a-zA-Z]|\d)*\Z/ }
  # validates :phone_number, format: { with: /\A\d{10}\z|\A\d{4}-{1}\d{6}\z/ , message: "bad format" }
  has_many :staffs
  has_one :cart
  has_many :restaurants
  has_many :wait_queues
  has_many :restaurant_tables
  has_many :restaurants, through: :staffs
  accepts_nested_attributes_for :restaurants
  has_many :orders
  has_many :hotels
  has_many :reviews, dependent: :destroy
  # validates :rating, numericality: { in: 0..5 }

  def active_for_authentication?
    super && special_condition_is_valid?
  end

  def active_for_authentication?
    super && !self.banned
  end

end
