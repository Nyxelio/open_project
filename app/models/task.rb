class Task < ActiveRecord::Base
  belongs_to :project
  has_one :family
  has_many :activities

  def exceeded?(options = {})
    sum = options.key?(:offset) ? options[:offset].to_d : 0.0
    real_duration + sum > estimated_duration
  end
end
