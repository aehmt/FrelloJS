class ListsController < ApplicationController
  before_action :authenticate_user!

  def create
    @list = List.new(list_params)
    if @list.save
      Feed.create(board_id: @list.board.id, list_id: @list.id, user_id: current_user.id, action: "#{current_user.email[0].upcase} created the list: #{@list.title}")
    end
      redirect_to user_board_path(current_user, @list.board)
  end

  def update
    @list = List.find_by(id: params[:id])
    if @list.update(list_params)
      Feed.create(board_id: @list.board.id, list_id: @list.id, user_id: current_user.id, action: "#{current_user.email[0].upcase} updated the list: #{@list.title}")
    end
    redirect_to user_board_path(current_user, @list.board)
  end

  private

  def list_params
    params.require(:list).permit(:title, :board_id, :duedate)
  end
end
