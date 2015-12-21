# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  baseUrl = "http://devpoint-ajax-example-server.herokuapp.com/api/v1/products/"

  addToList = (id, name) ->
    $.ajax '/product_template',
      type: 'GET'
      data:
        id: id
        name: name
      dataType: 'HTML'
      success: (data) ->
        $('product_list').append(data)
      error: (data) ->
        console.log(data)

  loadProduct = ->
    $('#product_list').children().remove()
    $.ajax "#{baseUrl}",
      type: 'GET'
      success: (data) ->
        alert('You did it!')
      error: (data) ->
        alert('You did not do it!')

  loadProduct()
