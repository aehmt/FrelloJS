class BoardsController < ApplicationController
  # after_action :show_home

  def index
    @tasks = current_user.tasks
    show_home
  end

  def create

  end

  def new

  end

  private
    def show_home(data = nil)
      redirect_to root_path(data) and return
    end
end
