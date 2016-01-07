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
        if product.quanity_on_hand > 0
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
    form = $(@)
    $.ajax baseUrl,
      type: 'POST'
      data: $(@).serializeArray()
      success: (data) ->
        addToList(data.product)
        $("#create_product")[0].reset()
        form.addClass('hide')
      error: (data) ->
        alert('Not Created')

  $(document).on 'click', '.product_delete', ->
    parent = $(@).parent()
    productId = $(@).attr('id')
    $.ajax baseUrl + productId,
      type: 'DELETE'
      success: (data) ->
        parent.slideToggle()
      error: (data) ->
        alert('did not delete')

  $(document).on 'click', '.product_edit', ->
    productId = $(@).attr('id')
    editForm = $(@).siblings('form')
    $.ajax baseUrl + productId,
      type: 'GET'
      success: (data) ->
        editForm.removeClass('hide')
        editForm.children('.edit_product_name').val(data.product.name)
        editForm.children('.edit_product_description').val(data.product.description)
        editForm.children('.edit_product_base_price').val(data.product.base_price)
        editForm.children('.edit_product_quanity_on_hand').val(data.product.quanity_on_hand)
        editForm.children('.edit_product_color').val(data.product.color)
        editForm.children('.edit_product_weight').val(data.product.weight)
      error: (data) ->
        alert('failure')

  $(document).on 'submit', '.edit_product', (e) ->
    e.preventDefault()
    form = $(@)
    productId = $(@).siblings('p:last').attr('id')
    $.ajax baseUrl + productId,
      type: 'PUT'
      data: $(@).serializeArray()
      success: (data) ->
        form.addClass('hide')
        loadProduct()
      error: (data) ->
        alert("submit edit failed")

  $(document).on 'click', '#toggle_create_form', ->
    $(this).siblings('form').removeClass('hide')

    # data: {product:{
    #   quanity_on_hand: 21-1
    # }}
  # works, hits success, now just need to make it do something
  $(document).on 'click', '.product_buy', ->
    quanityOfProduct = $(this).siblings('.quanity_display').attr('data-quanity')
    newQuanity = parseInt(quanityOfProduct) - 1
    productId = $(@).attr('id')
    $.ajax baseUrl + productId,
      type: 'PUT'
      data:
        product:
          quanity_on_hand: newQuanity
      success: (data) ->
        alert('success buy')
      error: (data) ->
        alert('Failed to buy')
