class CardsController < ApplicationController
  def create
    @card = Card.new(card_params)
    if @card.save
      Feed.create(board_id: @card.list.board.id, card_id: @card.id, user_id: current_user.id, list_id: @card.list_id, action: "#{current_user.email[0].upcase} created a card in #{@card.list.title}")
      redirect_to user_board_path(current_user, @card.list.board)
    end
  end

  def update
    @card = Card.find_by(id: params[:id])
    if params[:update_type] == "toggle_check"
      @card.update(checked: !@card.checked)
      Feed.create(board_id: @card.list.board.id, card_id: @card.id, user_id: current_user.id, list_id: @card.list_id, action: "#{current_user.email[0].upcase} marked the card (#{@card.content}) in #{@card.list.title} #{'un' if !@card.checked}completed.")
    else
      @card.update(card_params)
      Feed.create(board_id: @card.list.board.id, card_id: @card.id, user_id: current_user.id, list_id: @card.list_id, action: "#{current_user.email[0].upcase} updated a card in #{@card.list.title}")
    end
    redirect_to user_board_path(current_user, @card.list.board)
  end

  private

  def card_params
    params.require(:card).permit(:content, :list_id)
  end
end
