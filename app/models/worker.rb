class Worker < ActiveRecord::Base
  has_many :activities


def name
  @name ||= [firstname, lastname].join(' ')
end

end
