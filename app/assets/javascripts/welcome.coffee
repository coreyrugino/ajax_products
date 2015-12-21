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
    $.ajax baseUrl,
      type: 'GET'
      success: (data) ->

        if data.products.length
          for product in data.products
            addToList product
        else
          alert('No products')
      error: (data) ->
        alert('You did not do it!')

  loadProduct()

  $('#create_product').on 'submit', (e) ->
    e.preventDefault()
    $.ajax baseUrl,
      type: 'POST'
      data: $(@).serializeArray()
      success: (data) ->
        addToList(data.product)
        $("#create_product")[0].reset()
      error: (data) ->
        alert('Not Created')

  $(document).on 'click', '.product_delete', ->
    parent = $(@).parent()
    productId = $(this).attr('id')
    $.ajax baseUrl + productId,
      type: 'DELETE'
      success: (data) ->
        parent.slideToggle()
      error: (data) ->
        alert('did not delete')
        
