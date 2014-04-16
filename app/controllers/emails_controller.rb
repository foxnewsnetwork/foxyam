class EmailsController < ApplicationController
  expose(:presenter) { _presenter }
  def show; end
  private
  def _presenter
    @presenter ||= Emails::Presenter.new _email, current_merchant
  end
  def _email
    @email ||= FoxYam::Email.find params[:id]
  end
end