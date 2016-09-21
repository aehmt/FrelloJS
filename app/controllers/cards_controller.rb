class CardsController < ApplicationController
  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to user_board_path(current_user, @card.task.board)
    else
      return render :new
    end
  end

  def update
    @card = Card.find_by(id: params[:id])
    @card.update(card_params)
    redirect_to user_board_path(current_user, @card.task.board)
  end

  private

  def card_params
    params.require(:card).permit(:content, :task_id)
  end
end
