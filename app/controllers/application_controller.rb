class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?, only: [:create]
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if resource.admin?
      rails_admin_path # or any other admin page path
    else
      root_path # or any other default page path
    end
  end

  protected

  def configure_permitted_parameters
    if params["user"]["role"] == "0"
    	params["user"]["role"] = "customer"
    	attributes = [:role]
    	devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    else
    	attributes = [:role]
    	devise_parameter_sanitizer.permit(:sign_up, keys: attributes)

    end
	end
end
