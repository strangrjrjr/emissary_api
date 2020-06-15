class ApplicationController < ActionController::API
    before_action :authorized

    # CHANGE SECRET AND REMOVE TO ENV BEFORE PRODUCTION
    def encode_token(payload)
        JWT.encode(payload, 'secret')
    end

    def auth_header
        # { 'Authorization': 'Bearer <token>' }
        request.headers['Authorization']
    end
     
      def decoded_token
            if auth_header
                token = auth_header.split(' ')[1]
                # headers: { 'Authorization': 'Bearer <token>' }
                begin
                    # CHANGE SECRET AND REMOVE TO ENV BEFORE PRODUCTION
                    # leeway for token expiration
                    leeway = 30
                    JWT.decode(token, 'secret', true, {exp_leeway: leeway, algorithm: 'HS256'})
                rescue JWT::DecodeError
                    nil
                end
            end
        end

    def current_user
        if decoded_token
          user_id = decoded_token[0]['user_id']
          @user = User.find_by(id: user_id)
        end
    end
     
    def logged_in?
        !!current_user
    end

    def authorized
        render json: { error: 'Please log in' }, status: :unauthorized unless logged_in?
    end
end
