class Assignment < ApplicationRecord
  belongs_to :course
  has_one_attached :submission 
  validates :weightage, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 50
  }
  validates_each :submission do |record|
    if !record.can_submit?
      record.errors.add("You cannot submit after the deadline.")
    end 
  end 

  def can_submit? 
    return DateTime.now <= submission_deadline 
  end 
end
