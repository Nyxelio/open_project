class Worker < ActiveRecord::Base
  has_many :activities
  validates :name, :cost_hour, presence: true
end
