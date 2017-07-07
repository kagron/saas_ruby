class ContactsController < ApplicationController
   # GET request to /contact_us
   # Show new contact form
   def new
      @contact = Contact.new
   end
   
   # POST request /contacts
   def create
      # Mass assignment of form fields into a contact object
      @contact = Contact.new(contact_params)
      if @contact.save
         # Save the object to a database and if it goes through, send email
         name = params[:contact][:name]
         email = params[:contact][:email]
         body = params[:contact][:comments]
         # plug variables into Contact mailer email method
         ContactMailer.contact_email(name, email, body).deliver
         #Store success message in flash hash
         flash[:success] = "Message sent"
         redirect_to new_contact_path
      else 
         # If save fails, show errors in readable sentences
         flash[:danger] = @contact.errors.full_messages.join(", ")
         redirect_to new_contact_path
      end
   end
   
   private
   # To collect data from form, we need to use strong parameters
      def contact_params
         params.require(:contact).permit(:name, :email, :comments)
      end
end