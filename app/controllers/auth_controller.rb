class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]
 
    def create
      @user = User.find_by(username: user_login_params[:username])
      
      if @user && @user.authenticate(user_login_params[:password])
        # one day for token
        @exp = Time.now.to_i + 86400
        token = encode_token({ user_id: @user.id, exp: @exp})
        ActionCable.server.broadcast("appearances_channel", @user)
        render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
      else
        render json: { message: 'Invalid username or password' }, status: :unauthorized
      end
    end

    def show
      render json: {message: "Authorized"}
    end
   
    private
   
    def user_login_params
      params.require(:user).permit(:username, :password)
    end
end
