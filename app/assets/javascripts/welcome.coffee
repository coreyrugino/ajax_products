# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  baseUrl = "http://devpoint-ajax-example-server.herokuapp.com/api/v1/products/"

  addToList = (product) ->
    $.ajax '/product_template',
      type: 'GET'
      data:
        product: product
      dataType: 'HTML'
      success: (data) ->
        $('#product_list').append(data)
      error: (data) ->
        console.log(data)

  loadProduct = ->
    $('#product_list').children().remove()
    $.ajax "#{baseUrl}",
      type: 'GET'
      success: (data) ->
        debugger
        if data.products.length
          for product in data.products
            addToList product
        else
          alert('No products')
      error: (data) ->
        alert('You did not do it!')

  loadProduct()
