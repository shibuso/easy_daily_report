class PageController < ApplicationController

  def index
    redirect_to reports_url and return if current_user
    render layout: false
  end

end
