# coding: utf-8
class TicketsController < MainApplicationController
  before_filter :ticket_new, :only => [:index,:create]

  def index
    
  end

  def create
    @ticket = Ticket.new params[:ticket]
    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.js { render :layout => false }
    end
  end

private
  def ticket_new
    @ticket = Ticket.new
  end

end
