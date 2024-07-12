class ElementsController < ApplicationController
  def index
    @elements = Element.all
  end
end
