class ListsController < ApplicationController
  before_action :authenticate_user!

  def create

    @list = List.new(list_params)
    # binding.pry
    if @list.save
      redirect_to user_board_path(current_user, @list.board)
    else
      return render :new
    end
  end

  def update
    @list = List.find_by(id: params[:id])
    # return head(:forbidden) unless current_user.try(:id) == @list.id
    @list.update(list_params)
    redirect_to user_board_path(current_user, @list.board)
  end

  private

  def list_params
    params.require(:list).permit(:title, :board_id)
  end
end
