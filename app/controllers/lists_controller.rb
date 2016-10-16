class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:update, :destroy]

  def show
    @list = List.find(params[:id])
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @list }
    end
  end

  def create
    @list = List.new(list_params)
    if @list.save
      Feed.create(board_id: @list.board.id, list_id: @list.id, user_id: current_user.id, action: "created list #{@list.title}")
    end
    render json: @list
    
    # redirect_to user_board_path(current_user, @list.board)
  end

  def update
    if @list.update(list_params)
      Feed.create(board_id: @list.board.id, list_id: @list.id, user_id: current_user.id, action: "updated list #{@list.title}")
    end
    redirect_to user_board_path(current_user, @board)
  end

  def destroy
    @list.destroy
    redirect_to user_board_path(current_user, @board)
  end

  private

  def set_list
    @list = List.find_by(id: params[:id])
    @board = @list.board
  end

  def list_params
    params.require(:list).permit(:title, :board_id, :duedate)
  end
end
