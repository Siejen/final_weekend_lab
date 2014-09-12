class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]
  # create a before_action that just returns the template
  #   without the layout
  before_action :render_main_layout_if_format_html

  respond_to :json, :html

  def index
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def render_main_layout_if_format_html
    # check the request format
    if request.format.symbol == :html
      render "layouts/application"
    end
  end

end
