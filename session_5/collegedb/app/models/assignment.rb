class Assignment < ApplicationRecord
  belongs_to :course
  has_one_attached :submission 
  validates :weightage, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 50
  }
  validate :submit_within_deadline

  def submit_within_deadline 
    if DateTime.now > submission_deadline
      errors.add(:submission_deadline,"is long gone")
    end  
  end 
end
