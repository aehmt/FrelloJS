class ProfileController < ApplicationController
  def home
    @user = current_user
    @boards = @user.boards
    @new_board = Board.new
  end
end
