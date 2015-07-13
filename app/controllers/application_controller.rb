class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
   protect_from_forgery with: :exception, :if => Proc.new { |c| c.request.format == 'application/json' }
  #protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?


 



def after_sign_in_path_for(resource)
    if current_user.role == "super_admin" || current_user.role == "admin"
      if current_user.status == true
        '/admin'
      else
        raise "ad"
         flash[:notice] = "This account has been Blocked - Please Contact Super Admin."
         #redirect_to '/users/sign_in'
         return unauthenticated_root_url
      end
    	  #users_admin_path
        
        
    elsif current_user.role == "doctor" || current_user.role == "reception"
     #users_other_path
     if current_user.status == true
        '/custshow'
        
      else
         flash[:notice] = "This account has been Blocked - Please Contact Super Admin."
         #redirect_to '/users/sign_in'
         return unauthenticated_root_url
         
      end
     
       
    end
end

 
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:firstname, :lastname, :username, :date_of_birth, :email, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache ) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:firstname, :lastname, :username, :date_of_birth, :email, :password, :password_confirmation, :current_password,:avatar, :avatar_cache) }
  end


end
