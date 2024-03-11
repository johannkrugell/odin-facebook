class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
 
  def github
    user = User.from_omniauth(auth)
    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise_omniauth_callbacks.success', kind: 'Github'
      sign_in_and_redirect user 
    else
      flash[:alert] = 
      t 'devise_omniauth_callbacks.failure', kind: 'Github', reason: "#{auth.info.email} is not authorized"
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    user = User.from_omniauth(auth)
    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise_omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect user 
    else
      flash[:alert] = 
      t 'devise_omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized"
      redirect_to new_user_registration_url
    end
  end  
  
  private

  def auth
    auth ||= request.env['omniauth.auth']
  end
end