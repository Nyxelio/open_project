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


  $('#container-task-workers').highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: null
      plotShadow: false
      type: 'pie'
    credits: enabled: false
    title: text: 'Répartition du temps par collaborateur'
    tooltip: pointFormat: '{series.name}: <b>{point.value:.1f}h</b>'
    plotOptions: pie:
      allowPointSelect: true
      cursor: 'pointer'
      dataLabels: enabled: false
      showInLegend: true
    series: [ {
      name: 'Activités'
      colorByPoint: true
      data: $('#container-task-workers').data('series')
    } ]
    
  $('#container-task-activities').highcharts
    chart: type: 'column'
    title: text: 'Récapitulatif des activités'
    credits: enabled: false
    subtitle: text: ''
    xAxis:
      type: 'category'
#      categories: $('#container-task-activities').data('categories')
      crosshair: true
    yAxis:
      min: 0
      title: text: 'Activités (h)'
    tooltip:
      headerFormat: '<span style="font-size:10px">{point.key}</span><table>'
      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' + '<td style="padding:0"><b>{point.y:.1f} h</b></td></tr>'
      footerFormat: '</table>'
      shared: true
      useHTML: true
    legend:
      enabled: false
    plotOptions: series:
      pointPadding: 0.2
      borderWidth: 0
      dataLabels:
        enabled: true
        format: '{point.y:.1f}h'
    series:  [{
      name: 'Activités',
      colorByPoint: true,
      data: $('#container-task-activities').data('series')
    }]

$(document).ready $.loadGantt
$(document).on 'page:load page:change', $.loadGantt
