class BoardsController < ApplicationController
  before_action :find_board, only: [:show, :update]

  def index

    @boards = current_user.boards
    # @lists = @boards.lists
    @last_board = Board.last
    # redirect_to root_path and return
    # render :json => @boards.as_json

    # respond_to do |format|
      # format.html { redirect_to root_path }
      # format.json { render json: @boards }
    #
    # end
    render json: @boards
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
    render json: @board, status: 201
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
