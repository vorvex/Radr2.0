class PageViewController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create 
    referrer = params[:referrer]
    path = params[:path]
    session = Session.find_by_token(params[:session_token])
    user_agent = params[:user_agent]
    user = User.find(params[:user_id].to_i)
    
    PageView.create(referrer: referrer, params: params[:params], path: path, session_id: session.id, user_agent: user_agent, user: user)
    
    respond_to do |format|
      format.js { render :js => "console.log('PageView created')"}
    end
  end

end
