class Student < ApplicationRecord
    has_many :registrations
    has_many :courses, through: :registrations
    validates :admission_year, numericality: {
        greater_than_or_equal_to: 2017,
        less_than_or_equal_to: 2021
    }
end
