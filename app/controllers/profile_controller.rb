class ProfileController < ApplicationController
  def home
    @user = current_user
    @boards = @user.boards.order(:starred).reverse_order
    @new_board = Board.new
  end
end
