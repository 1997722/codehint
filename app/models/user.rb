class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments

  validates :nickname, presence: true, length: { maximum: 6 }
  validates :password,
  format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i,message: 'は半角英数字混合での入力が必要です'},
  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}
  
end
