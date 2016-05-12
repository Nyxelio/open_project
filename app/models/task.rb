class Task < ActiveRecord::Base
  belongs_to :project
  has_one :family
  has_many :activities
end
