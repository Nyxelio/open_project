# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.loadStats = ->
  $('#container-chart-activities').highcharts
    chart: type: 'column'
    title: text: 'Récapitulatif des activités'
    credits: enabled: false
    subtitle: text: ''
    xAxis:
      categories: $('#container-chart-activities').data('categories')
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
    plotOptions: column:
      pointPadding: 0.2
      borderWidth: 0
    series: $('#container-chart-activities').data('series')

  $('#container-chart-tasks').highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: 0
      plotShadow: false
    credits: enabled: false
    title:
      text: 'Répartition<br>par tâche'
      align: 'center'
      verticalAlign: 'middle'
      y: 40
    tooltip: pointFormat: '{series.name}: <b>{point.value:.1f}h</b>'
    plotOptions: pie:
      dataLabels:
        enabled: true
        distance: -50
        style:
          fontWeight: 'bold'
          color: 'white'
          textShadow: '0px 1px 2px black'
      startAngle: -90
      endAngle: 90
      center: [
        '50%'
        '75%'
      ]
    series: [ {
      type: 'pie'
      name: 'Répartition par tâche'
      innerSize: '50%'
      data: $('#container-chart-tasks').data('series')
    }]

  $('#container-family-tasks').highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: 0
      plotShadow: false
    credits: enabled: false
    title:
      text: 'Répartition<br>par famille'
      align: 'center'
      verticalAlign: 'middle'
      y: 40
    tooltip: pointFormat: '{series.name}: <b>{point.value:.1f}h</b>'
    plotOptions: pie:
      dataLabels:
        enabled: true
        distance: -50
        style:
          fontWeight: 'bold'
          color: 'white'
          textShadow: '0px 1px 2px black'
      startAngle: -90
      endAngle: 90
      center: [
        '50%'
        '75%'
      ]
    series: [ {
      type: 'pie'
      name: 'Répartition par famille'
      innerSize: '50%'
      data: $('#container-family-tasks').data('series')
    } ]

  $('#container-duration-tasks').highcharts
    chart: type: 'bar'
    title: text: 'Répartition du temps par tâche'
    credits: enabled: false
    subtitle: text: ''
    xAxis:
      categories: $('#container-duration-tasks').data('categories')
      title: text: null
    yAxis:
      min: 0
      title:
        text: 'Temps (h)'
        align: 'high'
      labels: overflow: 'justify'
    tooltip: valueSuffix: ' heures'
    plotOptions: bar: dataLabels: enabled: true
    legend:
      layout: 'vertical'
      align: 'right'
      verticalAlign: 'top'
      x: -40
      y: 80
      floating: true
      borderWidth: 1
      backgroundColor: Highcharts.theme and Highcharts.theme.legendBackgroundColor or '#FFFFFF'
      shadow: true
    credits: enabled: false
    series: $('#container-duration-tasks').data('series')

$(document).ready $.loadStats
$(document).on 'page:load', $.loadStats
