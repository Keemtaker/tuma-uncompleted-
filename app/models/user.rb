class User < ApplicationRecord
  after_create :send_welcome_email
  has_many :companies
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private
  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
