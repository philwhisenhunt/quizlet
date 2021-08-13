json.extract! quiz, :id, :name, :difficulty, :created_at, :updated_at
json.url quiz_url(quiz, format: :json)
