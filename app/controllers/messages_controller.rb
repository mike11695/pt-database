class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  
  def index
    @messages = @conversation.messages
    
    if @messages.length > 5
      @over_ten = true
      @messages = @messages[-5..-1]
    end
    
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    
    @messages.each do |message|
      if user_signed_in?
        if message.user_id != current_user.id
          if message.read == false
            message.read = true
            message.save
          end
        end
      end
    end
    
    #if @messages.last
      
      #if admin_signed_in? || @messages.last.user_id != current_user.id
        #@messages.last.read = true;
      
      #end
      
    #end
    
    @message = @conversation.messages.new
    
  end
  
  def new
    @message = @conversation.messages.new
  end
  
  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      flash[:danger] = @message.errors.full_messages.join(", ")
      redirect_to conversation_messages_path
    end
  end
  
  private
  
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
    
end