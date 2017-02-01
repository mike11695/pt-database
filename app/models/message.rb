class Message < ActiveRecord::Base
  validates_presence_of :conversation_id, :user_id
  validates :body, presence: true, length: { maximum: 500 , too_long: "%{count} is too long, maximum is 500 characters" }, obscenity: true
  
  belongs_to :conversation
  belongs_to :user
  
  def message_time
    created_at.strftime("%m/%d/%y at %r")
  end
  
end