class User < ApplicationRecord
  validates_presence_of :name
  validates :password_digest, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :user_parties
  has_many :viewing_parties, through: :user_parties

   # bcrypt
   has_secure_password # automatically adds :password_confirmation attribute and validates
end
