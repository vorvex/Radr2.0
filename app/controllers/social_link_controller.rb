class SocialLinkController < ApplicationController
  def create 
    @link = SocialLink.create(url: params[:social_link][:url], performer_id: params[:performer_id], channel: params[:social_link][:channel])
    @container = params[:container]
    if @link.save
      respond_to do |format|
        format.js { render partial: 'social_link/create' }
      end
    end
  end

  def edit
  end

  def destroy
    @link = SocialLink.find(params[:id])
    if @link.delete
      respond_to do |format|
        format.js { render partial: 'social_link/destroyed' }
      end
    end
  end
end
