class WelcomeController < ApplicationController
  def index
  end

  def product_template
    @id = params[:id]
    @name = params[:name]

    render partial: 'product_template'
  end
end
