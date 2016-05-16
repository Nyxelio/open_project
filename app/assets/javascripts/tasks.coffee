# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  $("#provisionalSchedule").gantt
    source: $("#provisionalSchedule").data('provisional-gantt')
    scale: 'days'
    minScale: 'days'
    maxScale: 'months'
    navigate: 'scroll'
  console.log $("#provisionalSchedule").data('provisional-gantt')
