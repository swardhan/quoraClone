class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  validates_presence_of :title
  validates_presence_of :description
end
