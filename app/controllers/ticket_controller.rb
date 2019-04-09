class TicketController < ApplicationController
  def create
    @ticket = Ticket.create(name: params[:ticket][:name], event_id: params[:ticket][:event_id], url: params[:ticket][:url], status: params[:ticket][:status], price: params[:ticket][:price])
    @container = params[:container]
    if @ticket.save
      respond_to do |format|
        format.js { render partial: 'ticket/create' }
      end
    end
  end
  
  def edit 
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    @container = params[:container]
    @ticket.update(name: params[:ticket][:name], event_id: params[:event_id], url: params[:ticket][:url], status: params[:ticket][:status], price: params[:ticket][:price])
    
    respond_to do |format|
      format.js { render partial: 'ticket/updated' }
    end
    
  end
  
  def destroy
    @ticket = Ticket.find(params[:id])
    if @ticket.delete
      respond_to do |format|
        format.js { render partial: 'ticket/destroyed' }
      end
    end
  end
  
end
