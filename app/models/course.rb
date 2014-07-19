class Course < ActiveRecord::Base
  attr_accessible :duration, :fee, :name, :course_id
  validates :duration, :fee, :name, :presence=>true

  def self.search(search)
    if search
       where("name LIKE ?", "%#{search}%")
    else
      find(:all)
    end   
  end
end