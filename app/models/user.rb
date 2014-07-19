class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_id, :email, :password, :password_confirmation, :remember_me, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
  belongs_to :role
  validates :role_id, :presence=>true

  #before_save :ensure_confirmation_token

end