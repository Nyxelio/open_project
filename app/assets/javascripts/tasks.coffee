# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.loadGantt= ->
  $("#provisionalSchedule").gantt
    source: $("#provisionalSchedule").data('provisional-gantt')
    scale: 'days'
    minScale: 'days'
    maxScale: 'months'
    navigate: 'scroll'
    dow: ['D','L','M','M','J','V','S']
    months: ['jan', 'fév', 'mar', 'avr', 'mai', 'juin', 'juil', 'août', 'sept', 'oct', 'nov', 'déc']

$(document).ready $.loadGantt
$(document).on 'page:load page:change', $.loadGantt
