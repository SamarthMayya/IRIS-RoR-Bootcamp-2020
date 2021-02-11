class Student < ApplicationRecord
    has_many :registrations
    has_many :courses, through: :registrations
    has_many :submissions 
    validates :admission_year, numericality: {
        greater_than_or_equal_to: 2017,
        less_than_or_equal_to: 2021
    }
    validate :roll_number_should_begin_with_year, :roll_number_should_contain_course_code, :r_no_should_have_last_three_as_numbers

    def r_no_should_have_last_three_as_numbers
        if !(roll_number.last(3) =~ /\A\d\d\d\z/)
            errors.add(:roll_number,"must end with three numbers")
        end
    end 

    def roll_number_should_begin_with_year
        if !roll_number.starts_with?(admission_year.to_s.last(2))
            errors.add(:roll_number,"should start with year of admission") 
        end 
    end 

    def roll_number_should_contain_course_code
        code = branch.split.map(&:first).join
        if code.starts_with?('CS') && !roll_number.include?('CS') 
            errors.add(:roll_number,"should contain course code")
        elsif code.starts_with?('ME') 
            if branch = 'Mechanical Engineering' && !roll_number.include?('ME')
                errors.add(:roll_number,"should contain course code")
            elsif branch = 'Mining Engineering' && !roll_number.include?('MN')
                errors.add(:roll_number,"should contain course code")
            end 
        else 
            if code.starts_with?('EaC') && !roll_number.include?('EC')
                errors.add(:roll_number,"should contain course code")
            end 
        end 
    end 
end
