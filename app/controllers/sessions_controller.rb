class SessionsController < ApplicationController
  before_action :set_cache_headers
	def destroy
    sign_out(current_user)
    redirect_to root_path
  end
end