# Database Schema 

```ruby
ActiveRecord::Schema.define(version: 2021_02_03_104635) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assignments", force: :cascade do |t|
    t.string "name"
    t.datetime "submission_deadline"
    t.integer "weightage"
    t.integer "course_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "course_code"
    t.string "branch"
    t.integer "year"
    t.integer "credits"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.integer "course_id"
    t.integer "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "branch"
    t.integer "admission_year"
    t.string "email"
    t.string "roll_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_students_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
``` 
# Models, Associations and Validations
```ruby
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
```
```ruby
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
```

```ruby
class Registration < ApplicationRecord
    belongs_to :student
    belongs_to :course 
end
```

```ruby
class Student < ApplicationRecord
    has_many :registrations
    has_many :courses, through: :registrations
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
```
