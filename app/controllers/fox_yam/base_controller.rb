class FoxYam::BaseController < ApplicationController
  private
  def _wrong_users
    [_wrong_user]
  end

  def _correct_users
    [_correct_merchants.reject(&:blank?).map(&:users), _correct_user]
  end

  def _correct_merchants
    [_correct_merchant]
  end

  def _correct_merchant; end
  def _wrong_user; end
  def _correct_user; end

  def _reject_anonymous_users
    redirect_to new_user_session_path(back: request.path) unless user_signed_in?
  end

  def _reject_wrong_users
    redirect_to welcome_unauthorized_path(target: request.path) if _wrong_user?
  end

  def _select_correct_users
    redirect_to welcome_unauthorized_path(target: request.path) unless _correct_user?
  end

  def _wrong_user?
    _wrong_users.flatten.reject(&:blank?).include?(current_user)
  end

  def _correct_user?
    _correct_users.flatten.select(&:present?).include?(current_user)
  end

end