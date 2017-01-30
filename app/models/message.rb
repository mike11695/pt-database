class Message < ActiveRecord::Base
  
  belongs_to :conversation
  belongs_to :user
  
  validates_presence_of :body, :conversation_id, :user_id
  validates :body, length: { maximum: 500 , too_long: "%{count} is too long, maximum is 500 characters" }, obscenity: true
  
  def message_time
    created_at.strftime("%m/%d/%y at %r")
  end
  
end