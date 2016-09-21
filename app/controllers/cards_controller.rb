class CardsController < ApplicationController
  
  # def index
  #   @cards = current_user.cards
  #   show_home
  # end

  # def show
  #   @card = Task.find_by(id: params[:id])
  # end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to user_board_path(current_user, @card.task.board)
    else
      return render :new
    end
  end

#   def new
#     @card = Task.new
#     3.times {@cards = @card.cards.build} 
#   end

  def update
    @card = Card.find_by(id: params[:id])
    @card.update(card_params)
    redirect_to user_board_path(current_user, @card.task.board)
  end

  private

  def card_params
    params.require(:card).permit(:content)
  end
end
