class PageViewController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create 
    referrer = params[:referrer]
    path = params[:path]
    session = Session.find_by_token(params[:session_token])
    user_agent = params[:user_agent]
    user = User.find(params[:user_id].to_i)
    
    if user_agent.include?('iPhone') 
        user_agent2 = "iOS"
      elsif user_agent.include?('Android')
        user_agent2 = "Android"
      elsif user_agent.include?('Firefox')
        user_agent2 = "Firefox"
      elsif user_agent.include?('Chrome')
        user_agent2 = "Chrome"
      elsif user_agent.include?('Safari')
        user_agent2 = "Safari"
      elsif user_agent.include?('Windows NT')
        user_agent2 = "Internet Explorer"
      else
        user_agent2 = "Sonstige"
      end
    
    PageView.create(referrer: referrer, params: params[:params], path: path, session_id: session.id, user_agent: user_agent2, user: user)
    
    respond_to do |format|
      format.js { render :js => "console.log('PageView created')"}
    end
  end

end
