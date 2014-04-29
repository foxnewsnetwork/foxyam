module ApplicationHelper
  def company_legal_name
    I18n.t(:fuxueyan_imerchant)
  end

  def main_css_id
    cpath = request.path_parameters[:controller]
    action = request.path_parameters[:action]
    cpath.split("/").push(action).join "-"
  end

  def time_ago_in_words_with_nil(time, opts={})
    return I18n.t(:never) if time.blank?
    time_ago_in_words time, opts
  end

  def current_path
    request.path
  end

end
