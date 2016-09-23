require 'pry'
class BoardsController < ApplicationController
  before_action :find_board, only: [:show, :update]

  def index
    @boards = current_user.boards
    redirect_to root_path and return
  end

  def show
    @lists = @board.lists
    @new_list = List.new(duedate: DateTime.now.utc.end_of_day)
    @new_card = Card.new
    @feeds = @board.feeds.reverse
    # @feeds
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to user_boards_path(current_user)
    else
      redirect_to root_path, alert: 'Invalid Something'
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

    def find_board
      @board = Board.find_by(id: params[:id])
    end
end
