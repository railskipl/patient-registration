class User::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end


 def create
   if params[:device].present?
     #build_resource
    resource = User.find_for_database_authentication(:login=>params[:username])
    
    # return invalid_login_attempt unless resource
    if resource.nil?
      render :status => 401, :json => "Invalid User name"  
    else
      if resource.valid_password?(params[:password])
        sign_in("user", resource)
        render :status => 200, :json => "success  "
        return
      else 
        render :status => 401, :json => "Invalid password"
      end
    end
    else
      super
   end
end


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
