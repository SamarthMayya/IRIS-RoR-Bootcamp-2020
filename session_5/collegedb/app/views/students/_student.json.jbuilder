json.extract! student, :id, :name, :branch, :admission_year, :email, :roll_number, :created_at, :updated_at
json.url student_url(student, format: :json)
