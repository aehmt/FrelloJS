class CollaborationsController < ApplicationController
  before_action :set_collaboration, only: [:update, :destroy, :create]

  def create
    # binding.pry
    @collaboration = Collaboration.new(user_id: @user.id, card_id: params[:user][:card_id])
    if @collaboration.save
      Feed.create(board_id: @board.id, card_id: @card.id, user_id: current_user.id, list_id: @card.list_id, action: "#{current_user.email[0].upcase} added #{@user.email[0].upcase} to #{@card.content}")
    end
    redirect_to user_board_path(current_user, @board)
  end

  def update
    @collaboration.update(collaboration_params)
    redirect_to user_board_path(current_user, @board)
  end
  
  #not sure if neccessary
  # def destroy
  #   @collaboration.destroy
  #   redirect_to user_board_path(current_user, @board)
  # end

  private

  def set_collaboration
    @user = User.find_by(email: params[:user][:email])
    @board = Board.find_by(id: params[:user][:board_id])

    if @user == nil
      flash[:message] = "User doesn't exist!"
      redirect_to user_board_path(current_user, @board)
    end

    @collaboration = Collaboration.find_by(id: params[:id])
    @card = Card.find_by(id: params[:user][:card_id])
  end

  def collaboration_params
    params.require(:user).permit(:card_id, :email) #, :user_ids [], :board_id)
  end
end
