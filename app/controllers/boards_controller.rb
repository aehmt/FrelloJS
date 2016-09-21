require 'pry'
class BoardsController < ApplicationController
  before_action :find_board, only: [:show, :update]

  def index
    @boards = current_user.boards
    show_home
  end

  def show
    @tasks = current_user.tasks
    # @feeds
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to user_boards_path(current_user)
    else
      redirect_to root_path, flash[:alert] = "invalid something"
    end
  end

  def update
    @board.update(board_params)
    redirect_to root_path
  end

  private
    def board_params
      params.require(:board).permit(:name, :color, :private, :starred)
    end

    def show_home(data = nil)
      redirect_to root_path(data) and return
    end

    def find_board
      @board = Board.find_by(id: params[:id])
    end
end
