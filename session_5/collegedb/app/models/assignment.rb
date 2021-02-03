class Assignment < ApplicationRecord
  belongs_to :course
  has_one_attached :submission 

  def can_submit? 
    return DateTime.now <= submission_deadline 
  end 
end
