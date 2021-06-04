class Setting < ActiveRecord::Base

  scope :hours_per_day, -> { where(label: 'hours_per_day').first.value.to_d }
end
