# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Setting.create(label: 'hours_per_day', value: '7')
n = Worker.create(name: 'Nicolas PROCUREUR', cost_hour: '45')
cr = Worker.create(name: 'Clément ROUSSY', cost_hour: '45')
cg = Worker.create(name: 'Clément GODART', cost_hour: '40')
j = Worker.create(name: 'Julien TISSERANT', cost_hour: '35')


Project.create(name: 'Projet fictif', is_close: true, estimated_start_at: '2016-01-03', estimated_end_at: '2016-01-30', estimated_duration: 70, real_start_at: '2016-01-04', real_end_at: '2016-02-07', real_duration: 100, difference_hour: 30)

# 6 days x 6 hours x 4 guys
p1 = Project.create(name: 'Appli gestion', is_close: false, estimated_start_at: '2016-05-11', estimated_end_at: '2016-05-20', estimated_duration: 144, real_start_at: '2016-05-11', real_end_at: '', real_duration: 0, difference_hour: 0)

f1 = Family.create(label: 'Conception')
f2 = Family.create(label: 'Réalisation')
f3 = Family.create(label: 'Webdesign')
f4 = Family.create(label: 'Stabilisation')

t1 = Task.create(code: 'TEK', label: 'Choix des techno', estimated_start_at: '2016-05-11', estimated_end_at: '2016-05-11', estimated_duration: 16, real_start_at: '2016-05-11', real_end_at: '2016-05-11', real_duration: 0, percent_progress: 100, ratio: 0, project: p1, family: f1 )
t2 = Task.create(code: 'ARC', label: 'Architecture', estimated_start_at: '2016-05-12', estimated_end_at: '2016-05-12', estimated_duration: 6, real_start_at: '2016-05-12', real_end_at: '2016-05-13', real_duration: 0, percent_progress: 100, ratio: 0, project: p1, family: f1 )
Task.create(code: 'ABC', label: 'Tâche fictive', estimated_start_at: '2016-05-12', estimated_end_at: '2016-05-12', estimated_duration: 6, real_start_at: '2016-05-12', real_end_at: '', real_duration: 0, percent_progress: 5, ratio: 0, project: p1, family: f1 )
t3 = Task.create(code: 'DEV', label: 'Développement', estimated_start_at: '2016-05-12', estimated_end_at: '2016-05-20', estimated_duration: 122, real_start_at: '2016-05-12', real_end_at: '', real_duration: 0, percent_progress: 20, ratio: 0, project: p1, family: f2 )

Activity.create(date_activity: '2016-05-11', num_hours: 2.25, worker: n, task: t1)
Activity.create(date_activity: '2016-05-11', num_hours: 2.25, worker: cr, task: t1)
Activity.create(date_activity: '2016-05-11', num_hours: 2.25, worker: cg, task: t1)
Activity.create(date_activity: '2016-05-11', num_hours: 2.25, worker: j, task: t1)

Activity.create(date_activity: '2016-05-12', num_hours: 3.5, worker: n, task: t2)
Activity.create(date_activity: '2016-05-12', num_hours: 3.5, worker: cr, task: t2)

Activity.create(date_activity: '2016-05-12', num_hours: 3, worker: n, task: t3)
Activity.create(date_activity: '2016-05-12', num_hours: 3, worker: cr, task: t3)


Activity.create(date_activity: '2016-05-13', num_hours: 6, worker: n, task: t3)
Activity.create(date_activity: '2016-05-13', num_hours: 6, worker: cr, task: t3)

