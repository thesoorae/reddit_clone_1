module ApplicationHelper

  def auth_token
    token = "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}'"
    token.html_safe
  end
end
