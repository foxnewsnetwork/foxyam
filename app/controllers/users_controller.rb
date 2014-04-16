class UsersController < ApplicationController
  expose(:user) { FoxYam::User.find params[:id] }
  def show; end
end