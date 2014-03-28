module ApplicationHelper
  def company_legal_name
    I18n.t(:fuxueyan_imerchant)
  end

  def main_css_id
    cpath = request.path_parameters[:controller]
    action = request.path_parameters[:action]
    cpath.split("/").push(action).join "-"
  end
end
