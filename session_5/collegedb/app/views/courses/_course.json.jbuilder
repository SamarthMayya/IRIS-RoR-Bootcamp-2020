json.extract! course, :id, :name, :course_code, :branch, :year, :credits, :created_at, :updated_at
json.url course_url(course, format: :json)
