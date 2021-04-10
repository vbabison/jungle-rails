class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true


  def self.authenticate_with_credentials(email,password)
       user = User.find_by_email(email.strip.downcase)
  end
end