# frozen_string_literal: true

module Dashboard
  # Callbacks for 3rd party authentication.
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    prepend_before_action { request.env['devise.skip_timeout'] = true }

    def indieauth
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.present?
        sign_in_and_redirect @user, event: :authentication
        flash[:notice] = "Logged in successfully with IndieAuth from #{@user.indieauth_profile_url}"
      else
        flash[:notice] = 'You must register first before connecting to IndieAuth'
        redirect_to root_path
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
