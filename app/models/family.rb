class Family < ActiveRecord::Base
  has_many :tasks

  validates :label, presence: true
end
