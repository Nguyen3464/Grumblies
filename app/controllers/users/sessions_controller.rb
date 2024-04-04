class Users::SessionsController < Devise::SessionsController
  respond_to :json

  # Custom action to retrieve the authentication token of the current user
  def get_token
    render json: { token: current_user.authentication_token }
  end

  private

  # Override respond_with method if needed
  def respond_with(resource, _opts = {})
    render json: resource
  end

  # Override respond_to_on_destroy method if needed
  def respond_to_on_destroy
    render json: { message: "Logged out." }
  end
end
