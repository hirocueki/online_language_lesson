class LessonFeedback < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
end
