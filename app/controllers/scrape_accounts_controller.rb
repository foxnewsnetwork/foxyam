class ScrapeAccountsController < ApplicationController

  def update
    _scrap!
    _render_flash!
    _get_out_of_here!
  end

  private
  def _scrap!
    @result = _interactor.scrape!
  end
  def _interactor
    @interactor ||= ScrapeAccounts::Interactor.new _email_account
  end
  def _email_account
    @email_account ||= FoxYam::EmailAccount.find params[:id]
  end
  def _render_flash!
    flash[:error] = t(:unable_to_fetch_emails_probably_because_it_is_not_time_yet) if @result.blank?
    flash[:sucess] = t(:fetched_emails_successfully) if @result.present?  
  end
  def _get_out_of_here!
    redirect_to email_account_path _email_account
  end
end