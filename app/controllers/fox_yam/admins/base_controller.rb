class FoxYam::Admins::BaseController < FoxYam::BaseController
  before_filter :_select_correct_users

  private
  def _correct_user
    FoxYam::User.admins
  end
end