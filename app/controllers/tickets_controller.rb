class TicketsController < MainApplicationController
  before_filter :ticket_new, :only => [:index,:create]

  def index
    
  end

  def create
#    redirect_to tickets_url
      
#    if @ticket.save
#      redirect_to tickets_url
#    else
#      render :index
#    end
    respond_to do |format|
        format.js {}
    end
  end

private
  def ticket_new
    @ticket = Ticket.new
  end

end
