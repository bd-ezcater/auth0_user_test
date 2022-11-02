module Api
  module V1
    class UsersController < ApplicationController
      protect_from_forgery except: :authenticate
      def index
        users = User.order('created_at DESC');
        render json: {status:'SUCCESS', message:'Retrieved all users', data:users}, status: :ok
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: {status:'SUCCESS', message:'User created', data:user}, status: :ok
        else
          render json: {status:'ERROR', message:'User not created', data:user.errors}, status: :unprocessable_entity
        end
      end

      def show
        user = User.find(params[:id])
        render json: {status:'SUCCESS', message:'Retrieved user', data:user}, status: :ok
      end

      def update
        user = User.find(params[:id])

        if user.update_attributes(user_params)
          render json: {status:'SUCCESS', message:'User updated', data:user}, status: :ok
        else
          render json: {status:'ERROR', message:'User not updated', data:user.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id])
        user.destroy
        render json: {status:'SUCCESS', message:'Deleted user', data:user}, status: :ok
      end

      def authenticate
        user = User.find_by(email: authn_params[:email])
        if !user.nil? && user.password == authn_params[:password]
          render json: {status:'SUCCESS', message:'User authenticated', data:user}, status: :ok
        else
          render json: {status:'ERROR', message:'Bad credentials'}, status: :unauthorized
        end
      end

      private

      def user_params
        params.permit(:id, :userid, :username, :password, :email, :email_verified, :first_name, :last_name, :nickname, :phone, :picture_url)
      end

      def authn_params
        params.permit(:email, :password)
      end

    end
  end
end
