class UsersController < ApplicationController

 before_filter :authenticate_user!, only: :admin
 before_filter :authenticate, only: [:admin,:new] #, :except => [:new, :edit , :create , :update , :destroy
   
    def authenticate
     unless current_user.role == "super_admin" || "admin"
        redirect_to root_path, :notice => "Access Denied"
     end
    end

    def home
    end

    def admin
      if current_user.role == "super_admin"
        @users = (current_user.blank? ? User.all : User.find(:all, :conditions => ["id != ?", current_user.id]))
        respond_to do |format|
        format.html
        format.json { render json: @users }
      end
      else
        @users = User.find(:all, :conditions => ["user_id = ?", current_user.id]);  #current_user.customers
        respond_to do |format|
        format.html
        format.json { render json: @users }
      end
      end
    end
                         
    def other
    end

    def new                            
      @user = User.new
      @specility = Speciality.all
    end

    def create                
         @user = User.new(user_params)
         @user.skip_confirmation!
         if @user.save
           flash[:success] ="New User created"
           redirect_to '/admin'
         else
           flash[:error] = "There was an error while creating user."
           redirect_to new_user_path
         end
    end

    def edit   
       @user = User.find (params[:id])
       @specility = Speciality.all
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
          flash[:success] = "User data Updated"
          redirect_to '/admin'
      else
          redirect_to :back
      end
    end

    def block 
      @user = User.find(params[:id])
      @user.status = !@user.status?
      @user.save!
      redirect_to :back
    end

    def detail
      @user = User.find(params[:id])
    end

    def destroy 
      @user = User.find(params[:id])
      @user.destroy
      redirect_to '/admin'
    end

    def show   
      @user=User.find(params[:id])
    end

    def cust
      @user1 = Customer.new
       1.times do
         customer_attachment = @user1.customer_attachments.build
       end

      if current_user.role == "admin"
         @user = User.where('user_id = ? and role = ?',current_user.id, "doctor")
      else
        @user = User.where('user_id = ? and role = ?',current_user.user_id, "doctor")
      end 
    end

    def cust_create
      @user1 = Customer.new(user1_params)    
        if @user1.save
          flash[:success] ="New User created"
          redirect_to '/custshow'
        else
           flash[:notice] = "There was an error while creating user."
           redirect_to customer_path
        end
    end

    def appointment_date
      @user = Customer.find(params[:data1]) rescue nil
    end

    def send_appointment
      @user = Customer.find(params[:cust_id]) rescue nil
      day   = params[:date][:day]
      month = params[:date][:month]
      year  = params[:date][:year]
      hour  = params[:date][:hour]
      min   = params[:date][:minute]
      date  = "#{year}-#{month}-#{day} #{hour}:#{min}"
      @user.updappointment = date
      @user.updappointment = @user.updappointment
      @user.save
      flash[:notice] = "Appointment Fixed!"
      redirect_to custshow_path
    end

    def cust_index
      if current_user.role == "super_admin"
          @user1 = Customer.all
          respond_to do |format|
            format.html
            format.json { render json: @user1 }
          end
      else
        if current_user.role == "doctor"
           @user_doc = Customer.where("user_id = ? or doc_id = ?", current_user.id, current_user.id) #Doc own created users
           # @user_admin = Customer.where('user_id = ?',current_user.user_id) # Admin created users
           # @user_reception = User.select('id,user_id').where('user_id = ? and role = ?',current_user.user_id, "reception").first
           # @user_rece = Customer.where('user_id = ?',@user_reception.id) # Reception created users
           @user1 = @user_doc
        elsif current_user.role == "reception"
             @user_rece = Customer.where("user_id = ?", current_user.id) #Reception own created users
             @user_admin = Customer.where('user_id = ?',current_user.user_id) # Admin created users
             @user_doctor = User.select('id,user_id').where('user_id = ? and role = ?',current_user.user_id, "doctor").first
             @user_doc = Customer.where('user_id = ?',@user_doctor.id) # Doc created users
             @user1 = @user_doc + @user_admin + @user_rece
        else  
           @user_admin = Customer.where('user_id = ?',current_user.id) # Admin created users
           @user1 =  @user_admin 
        end
          #@user1 = @user_doc + @user_admin + @user_rece
          respond_to do |format|
          format.html
          format.json { render json: @user1 }
         end
      end
    end


    def cust_edit   
       @user1 = Customer.find (params[:id])
      if current_user.role == "admin"
         @user = User.where('user_id = ? and role = ?',current_user.id, "doctor")
      else
        @user = User.where('user_id = ? and role = ?',current_user.user_id, "doctor")
      end
    end

    def cust_update
      @user1 = Customer.find(params[:customer][:id])
      if  @user1.update(user1_params)
          flash[:success] ="User data Updated"
          redirect_to '/custshow'
      else
          flash[:notice] = "There is Some Problem Related to your Data"
          redirect_to :back
      end
    end

    def cust_destroy 
      @user = Customer.find(params[:id])
      @user.destroy
      redirect_to '/custshow'
    end

    def appointment
      @user1 = Customer.find(params[:id])
      newuptdate = Date.today 
      @user1.updappointment = newuptdate
      @user1.save!
      redirect_to '/custshow'
    end

    def show_image
      image = Customer.find(params[:id])
      image1 = image.customer_attachments
      image1.each do |image|
        if image.id == params[:avatar].to_i
          @image = image
        else
          flash[:notice] ="There is Some Problem Related to your Image"
          #redirect_to :back
        end
      end
    end

    def edit_image
      @image = CustomerAttachment.find(params[:id])
    end

    def update_image
      @image = CustomerAttachment.find(params[:customer_attachment][:id])
      updateimage_params = params.require(:customer_attachment).permit(:avatar)
      if  @image.update(updateimage_params)
          flash[:success] ="User data Updated"
          redirect_to '/custshow'
      else
          flash[:notice] ="There is Some Problem Related top your Image"
          redirect_to :back
      end
    end

    def custimage_destroy
      @image = CustomerAttachment.find(params[:id])
      @image.destroy
      redirect_to '/custshow'
    end

    def pricri
      cust_id = params[:customer]
      @user_doctor = Precription.where('customer_id = ? and Date(created_at) == ?',cust_id,Date.today).first
      if @user_doctor.present?
         redirect_to edit_prescription_path(@user_doctor.id)
      else 
         @pricri = Precription.new 
      end 
    end

    def pricription 
      @pricri = Precription.new(pricri_params)
      if  @pricri.save
          flash[:success] = "New Prescription created"
          redirect_to custshow_path
      else
          flash[:notice] = "There was an error while creating Prescription."
          redirect_to customer_path
      end
    end

    def prescri_edit
      @user2 = Precription.find(params[:id]) 
    end

    def prescri_update
      @user2 = Precription.find(params[:precription][:id])
      if  @user2.update_attributes(pricri_params)
          flash[:success] = "User data Updated"
          redirect_to '/custshow'
      else
          redirect_to :back
      end
    end


    def edit_user   
       @user = User.find(params[:id])
    end

    def update_user
      @user = User.find(params[:user][:id])
      #if params[:user][:password] == params[:user][:password_confirmation]
        if @user.update_attributes(user_params)
          flash[:success] = "User Password Updated"
          redirect_to '/admin'
        else
          flash[:notice] = "Any thing should be wrong"
          redirect_to :back
        end
      # else
      #   flash[:notice] = "Any thing should be wrong"
      #   redirect_to :back
      # end
    end

    def prescri_list
      cust_id = params[:customer]
      @user_doctor = Precription.select('id,date_current,precription,customer_id,description').where('user_id = ? and customer_id = ?',current_user.id, cust_id)
    end


    private
       def user_params
         params.require(:user).permit(:firstname,:lastname, :username, :email, :password,:password_confirmation,:role,:user_id,:speciality_id)
       end

       def user1_params
         params.require(:customer).permit(:name, :description, :dob, :age,:avatar,:user_id,:doc_id,:reception_id,customer_attachments_attributes: [:avatar])
       end

       def pricri_params
          params.require(:precription).permit(:date_current, :precription, :user_id, :customer_id,:description)
       end
end