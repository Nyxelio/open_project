# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
#
#  $("[name='activity[worker_id]']").on 'change', (e) ->
#    worker_name = $(@).find("option:selected").text()

$.loadActivities = ->
  $("[name='activity[num_hours]']").on 'input', () ->
    $(".inline.alert").removeClass "alert"
    hours = $(@).val()
    return if isNaN(hours) or hours.length is 0
    worker_name = $("[name='activity[worker_id]']").find("option:selected").text()
    return if worker_name.length is 0
    date = $("[name='activity[date_activity]']").val()
    return if date.length is 0 or isNaN(Date.parse(date))
    date = new Date(Date.parse(date))

    $.getJSON $(@).closest("[data-search]").data('search'), date_activity: date.toISOString(), worker_name: worker_name, input: hours, (data) ->
      data.forEach (d) ->
        $("#activities").find("[data-id='#{d}']").addClass('inline alert')

  $("[name='activity[task_id]']").on 'change', (e) ->
    $(".inline.warning").removeClass "warning"
    task_id = $(@).val()
    return if isNaN(task_id) or task_id.length is 0
    hours = $("[name='activity[num_hours]']").val()
    return if isNaN(hours) or hours.length is 0

    $.getJSON $(@).closest("[data-search]").data('search'), task_id: task_id, input: hours, (data) ->
      data.forEach (d) ->
        $("#activities").find("[data-id='#{d}']").addClass('inline warning')

  $('.filtering').on 'click', () ->
    $('.filtering-target').toggleClass('visible');


$(document).ready $.loadActivities
$(document).on 'page:load', $.loadActivities