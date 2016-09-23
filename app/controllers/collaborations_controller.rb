class CollaborationsController < ApplicationController
  before_action :set_collaboration, only: [:update, :destroy, :create]

  def create
    @collaboration = Collaboration.new(collaboration_params)
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
    @collaboration = Collaboration.find_by(id: params[:id])
    @board = Board.find_by(id: params[:board_id])
  end

  def collaboration_params
    params.require(:collaboration).permit(:card_id, :user_ids [], :board_id)
  end
end
