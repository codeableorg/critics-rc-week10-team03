class CallbacksController < Devise::OmniauthCallbacksController
  def github
    auth_hash = request.env["omniauth.auth"]
    p "***************************************************"
    pp auth_hash
    p "***************************************************"
    @user = User.from_omniauth(auth_hash)
    sign_in_and_redirect(@user)
  end
end
