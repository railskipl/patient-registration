module Api
  module V2
    class UsersController < ApplicationController
      respond_to :json
      
      def admin
        respond_with User.all 
      end

      def cust_index
        respond_with Customer.all
     end
     # def home
     # end

    end
  end
end