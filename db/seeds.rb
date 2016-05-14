# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Setting.create(label: 'hours_per_day', value: '7')
n = Worker.create(firstname: 'Nicolas', lastname: 'PROCUREUR', cost_hour: '45')
cr = Worker.create(firstname: 'Clément', lastname: 'ROUSSY', cost_hour: '45')
cg = Worker.create(firstname: 'Clément', lastname: 'GODART', cost_hour: '40')
j = Worker.create(firstname: 'Julien', lastname: 'TISSERANT', cost_hour: '35')


Project.create(name: 'Projet fictif', is_close: true, estimated_start_at: '2016-01-03 10:00', estimated_end_at: '2016-01-30 19:00', estimated_duration: 70, real_start_at: '2016-01-04 12:00', real_end_at: '2016-02-07 12:00', real_duration: 100, difference_hour: 30)

p1 = Project.create(name: 'Appli gestion', is_close: false, estimated_start_at: '2016-05-11 10:00', estimated_end_at: '2016-05-20 18:00', estimated_duration: 36, real_start_at: '2016-05-11 10:00', real_end_at: '', real_duration: 0, difference_hour: 0)

Family.create(label: 'Conception')
Family.create(label: 'Réalisation')
Family.create(label: 'Webdesign')
Family.create(label: 'Stabilisation')

t1 = Task.create(code: 'TEK', label: 'Choix des techno', estimated_start_at: '2016-05-11 15:00', estimated_end_at: '2016-05-11 19:00', estimated_duration: 4, real_start_at: '2016-05-11 15:00', real_end_at: '2016-05-11 17:15', real_duration: 2.25, percent_progress: 100, ratio: 2.25/4, project: p1 )
t2 = Task.create(code: 'ARC', label: 'Architecture', estimated_start_at: '2016-05-12 09:00', estimated_end_at: '2016-05-12 12:00', estimated_duration: 3, real_start_at: '2016-05-12 09:00', real_end_at: '2016-05-12 12:00', real_duration: 3, percent_progress: 100, ratio: 1, project: p1 )
t3 = Task.create(code: 'DEV', label: 'Développement', estimated_start_at: '2016-05-12 14:00', estimated_end_at: '2016-05-20 12:00', estimated_duration: 18, real_start_at: '2016-05-12 14:00', real_end_at: '', real_duration: 0, percent_progress: 20, ratio: 0, project: p1 )

Activity.create(date_activity: '2016-05-11 15:00', num_hours: 2.25, worker: n, task: t1)
Activity.create(date_activity: '2016-05-11 15:00', num_hours: 2.25, worker: cr, task: t1)
Activity.create(date_activity: '2016-05-11 15:00', num_hours: 2.25, worker: cg, task: t1)
Activity.create(date_activity: '2016-05-11 15:00', num_hours: 2.25, worker: j, task: t1)

Activity.create(date_activity: '2016-05-12 09:00', num_hours: 3, worker: n, task: t2)
Activity.create(date_activity: '2016-05-12 09:00', num_hours: 3, worker: cr, task: t2)

Activity.create(date_activity: '2016-05-12 14:00', num_hours: 3, worker: n, task: t3)
Activity.create(date_activity: '2016-05-12 14:00', num_hours: 3, worker: cr, task: t3)


Activity.create(date_activity: '2016-05-13 09:00', num_hours: 6, worker: n, task: t3)
Activity.create(date_activity: '2016-05-13 09:00', num_hours: 6, worker: cr, task: t3)

