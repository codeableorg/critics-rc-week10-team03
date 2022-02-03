class RegistrationsController < Devise::RegistrationsController
  # The path used after sign up.
  def after_sign_up_path_for(_resource)
    root_path
  end
end
