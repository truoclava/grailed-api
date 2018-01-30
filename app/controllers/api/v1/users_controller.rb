class Api::V1::UsersController < Api::ApiApplicationController
  def create
    user = User.new(permitted_params.user)
    user.password = params["password"]
    if user.save
      access_token = login(user, true)
      render json: {user: user, token: access_token}.to_json, status: :ok
    else
      render json: {errors: user.errors.full_messages}.to_json, status: :unprocessable_entity
    end
  end
end
