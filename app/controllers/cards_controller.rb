class CardsController < ApplicationController

  before_action :set_card, only: [:update, :destroy]


  def create
    @card = Card.new(card_params)
    if @card.save
      Feed.create(board_id: @card.list.board.id, card_id: @card.id, user_id: current_user.id, list_id: @card.list_id, action: " created card #{@card.content} in #{@card.list.title}")
      redirect_to user_board_path(current_user, @card.list.board)
    end
  end

  def update
    if params[:update_type] == "toggle_check"
      @card.update(checked: !@card.checked)
      Feed.create(board_id: @card.list.board.id, card_id: @card.id, user_id: current_user.id, list_id: @card.list_id, action: " marked card #{@card.content} in #{@card.list.title} #{'un' if !@card.checked}completed.")
    else
      @card.update(card_params)
      Feed.create(board_id: @card.list.board.id, card_id: @card.id, user_id: current_user.id, list_id: @card.list_id, action: " updated card in #{@card.list.title}")
    end
    redirect_to user_board_path(current_user, @board)
  end

  def destroy
    @card.destroy
    redirect_to user_board_path(current_user, @board)
  end

  private

  def set_card
    @card = Card.find_by(id: params[:id])
    @board = @card.list.board
  end

  def card_params
    params.require(:card).permit(:content, :list_id)
  end
end
