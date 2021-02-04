class Course < ApplicationRecord
    has_many :registrations
    has_many :assignments
    has_many :students, through: :registrations
    validates :course_code, format: { with: /\A(CS|EC|ME|MN)\d\d\d\z/}
    validates :branch, inclusion: { :in => ["Computer Science and Engineering","Mechanical Engineering","Mining Engineering","Electronics and Communication Engineering"] }
    validates :year, numericality: {
        greater_than_or_equal_to: 1,
        less_than_or_equal_to: 4
    }
    validates :credits, numericality: {
        greater_than_or_equal_to: 1,
        less_than_or_equal_to: 6
    }
end
