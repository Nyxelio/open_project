class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :family
  has_many :activities

  validates :estimated_start_at, presence: true
  validates :estimated_end_at, presence: true
  validates :code, presence: true
  validates :label, presence: true
  validates :family, presence: true

  before_save do
    if self.estimated_end_at < self.estimated_start_at
      errors.add(:base, "must be superior to #{estimated_start_at}")
    end
  end

  def real_start_at
    Activity.where(task: id).order(date_activity: :asc).first.date_activity unless Activity.where(task: id).length == 0
  end

  def real_end_at
    Activity.where(task: id).order(date_activity: :desc).first.date_activity unless Activity.where(task: id).length == 0
  end

  def real_duration
    self['real_duration'] || 0
  end

  def ratio
    self['ratio'] || 0
  end
  def exceeded?(options = {})
    sum = options.key?(:offset) ? options[:offset].to_d : 0.0
    real_duration + sum > estimated_duration unless real_duration.nil?
  end

  def exceeded_end_date?(options = {})
    return false if real_end_at.nil?
    real_end_at > estimated_end_at
  end

  def exceeded_day?(options = {})
    return false if percent_progress == 100
    Date.today > estimated_end_at
  end

  def remaining
    @remaining ||= estimated_duration - (real_duration || 0)
  end

  def cost
    activities.collect(&:cost).inject(0, :+)
  end

  after_create :add_duration
  before_destroy :remove_duration
  around_update :update_duration

  def add_duration(duration = nil)
    real_duration = project.real_duration + (duration || self.real_duration || 0)
    difference_hour = real_duration - project.estimated_duration
    project.update!(real_duration: real_duration, difference_hour: difference_hour)
  end

  def update_duration

    duration = self.changes.key?('real_duration') ? self.changes['real_duration'][0] : self.real_duration
    remove_duration(duration)

    yield

    duration = self.changes.key?('real_duration') ? self.changes['real_duration'][1] : self.real_duration
    add_duration(duration)
  end

  def remove_duration(duration = nil)
    real_duration = project.real_duration - (duration || self.real_duration || 0)
    difference_hour = real_duration - project.estimated_duration
    project.update!(real_duration: real_duration, difference_hour: difference_hour)
  end

end
