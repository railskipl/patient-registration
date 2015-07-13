require 'api_constraints'
Task::Application.routes.draw do
   #devise_for :users

  #resources :users    
    devise_for :users, :controllers => { :registrations => "user/registrations",:sessions => "user/sessions" }
    
    # resources :users
    # root "users#home"
    devise_scope :user do
      authenticated :user do
        root 'user/sessions#destroy', as: :authenticated_root
      end

      unauthenticated do
        root 'devise/sessions#new', as: :unauthenticated_root
      end
    end

  scope 'admin' do
    resources :users 
  end

   


  

   #Redirects us to homepage

namespace :api , defaults: {format: 'json'} do
     # scope module: :v1, constraints: ApiConstraints.new(version: 1) do
    namespace :v1 do
       get "admin" => "users#admin"
       post "admin" => "users#admin"
       get "custshow" => "users#cust_index"
       #post "/custshow" => "users#cust_index"
       
       
    end
    
  end
       get "users/:id" => "users#show", as: :show_user
       get "users/:id/delete" => "users#destroy"
       get "home" => "users#home"
       get "other" => "users#other" 
       get "admin" => "users#admin"
       get "custshow" => "users#cust_index"
       get "customer" => "users#cust"
       post "cust" => "users#cust_create" 
       
       get "custshow/:id/delete" => "users#cust_destroy"
       get "custshow/:id/edit" => "users#cust_edit" ,as: :edit_customer
       patch "customer" => "users#cust_update"
       get "users/:id/block" => "users#block" 
       get "custshow/:id/appointment" => "users#appointment"

       get "prescription" => "users#pricri",as: :prescription
       post "prescri" => "users#pricription"

       get "prescriptionlist" => "users#prescri_list"

       get "prescrishow/:id/edit" => "users#prescri_edit" ,as: :edit_prescription
       patch "prescription" => "users#prescri_update"

       get "image" => "users#show_image"
       post "appointment_date" => "users#appointment_date"

       get "change_pwd/:id/edit" => "users#edit_user" ,as: :edit_password
       patch "change" => "users#update_user"

       post "send_appointment" => "users#send_appointment", as: :send_appointment

       get "change_image/:id/edit" => "users#edit_image" ,as: :edit_image
       patch "alterimage" => "users#update_image"
       get "cust_image/:id/delete" => "users#custimage_destroy"

  # Redirects us to admin page

   # Redirects us to other than admin page

  
 
  # get "users/detail" => "users#detail"


 # get "users/show/:d" => "user#show"

end
