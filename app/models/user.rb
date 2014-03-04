class User < ActiveRecord::Base
  has_secure_password

  #DO I NEED TO BE CHANGED? REMEMBER TO CHANGE ME
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates :password, presence: true
  # Remember to create a migration!
end
