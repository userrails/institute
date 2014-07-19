class Role < ActiveRecord::Base
  attr_accessible :role_name
  has_many :users, :dependent=>:destroy
  validates :role_name, :uniqueness=>true
end