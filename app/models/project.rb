class Project < ActiveRecord::Base
  has_many :tasks

  def real_start_at
    Task.where(project: id).collect(&:real_start_at).compact.sort.first
  end

  def real_end_at
    Task.where(project: id).collect(&:real_end_at).compact.sort.first
  end

  def real_duration
    self['real_duration'] || 0
  end

  def percent_progress
    count = tasks.count
    count > 0 ? ((tasks.sum(:percent_progress).to_f || 0 ) / count).round(1) : 0
  end

  def exceeded?(options = {})
    tasks.collect(&:exceeded?).flatten.include?(true)
  end

  def difference_hour
    @difference_hour ||= estimated_duration - (real_duration || 0)
  end
end
