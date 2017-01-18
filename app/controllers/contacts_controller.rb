class ContactsController < ApplicationController
  
  # GET request to /contact_us
  # Show new contact form 
  def new
    @contact = Contact.new
  end
  
  # POST request /contacts
  def create
    # Mass assignment of form fields into Contact object
    @contact = Contact.new(contact_params)
    # Save the Contact object to the database
    if @contact.save
      # Store form fields via paramaters, into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Plug variables into Contact mailer
      # email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # Store success message into flash hash
      # and redirect to new action
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      # If contact object doesn't save,
      # store errors to flash hash,
      # and redirect to the new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
      # Use this to make custom error messages {key: value, key: value, error: "Name can't be blank."}
      # Use with <%= flash[error:] %>
      redirect_to new_contact_path, notice: "Error occured."
    end
  end
  
  private
  
  def contact_params
    # To collect data from form, we need to use strong paramaters
    # and whitelist the form fields
    params.require(:contact).permit(:name, :email, :comments)
  end
  
end