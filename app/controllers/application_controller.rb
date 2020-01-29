class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :banned?
  before_action :convo

  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:error] = "This account has been banned for violating site rules."
      root_path
    end
  end

  def convo
    @unread = 0
    @users = User.includes(:profile)
    @conversations = Conversation.all.order("created_at DESC")
    if user_signed_in?
      @conversations.each do |conversation|
        if conversation.sender_id == current_user.id || conversation.recipient_id == current_user.id
          if conversation.messages.last
            if conversation.messages.last.read == false && conversation.messages.last.user_id != current_user.id
              @unread += 1
            end
          end
        end
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :terms, :age) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:username, :email, :password, :password_confirmation, :current_password)}
  end
end
