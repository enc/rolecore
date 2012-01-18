# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#up').click ->
    window.planemanager.move('up')
  $('#down').click ->
    window.planemanager.move('down')
  $('#left').click ->
    window.planemanager.move('left')
  $('#right').click ->
    window.planemanager.move('right')
  $('#in').click ->
    window.planemanager.enlarge()
  $('#out').click ->
    window.planemanager.shrink()
