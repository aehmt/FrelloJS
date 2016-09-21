class TasksController < ApplicationController
  # after_action :show_home
  before_action :authenticate_user!

  # def index
  #   @tasks = current_user.tasks
  #   show_home
  # end

  # def show
  #   @task = Task.find_by(id: params[:id])
  # end

  def create

    @task = Task.new(task_params)
    if @task.save
      redirect_to user_board_path(current_user, @task.board)
    else
      return render :new
    end
  end

#   def new
#     @task = Task.new
#     3.times {@cards = @task.cards.build} 
#   end

  def update
    @task = Task.find_by(id: params[:id])
    # return head(:forbidden) unless current_user.try(:id) == @task.id
    @task.update(task_params)
    redirect_to user_board_path(current_user, @task.board)
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end
end
