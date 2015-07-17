Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_CONFIG[:"#{Rails.env}"]['app_id'],FACEBOOK_CONFIG[:"#{Rails.env}"]['secret'],{
           :scope => 'email,user_birthday', :display => 'popup', auth_type: 'reauthenticate'}

  provider :twitter, TWITTER_CONFIG[:"#{Rails.env}"]['api_key'],TWITTER_CONFIG[:"#{Rails.env}"]['api_secret'],
    {
      :secure_image_url => 'true',
      :image_size => 'original',
      :authorize_params => {
      :force_login => 'true',
      :lang => 'en'
    }
  }

  provider :google_oauth2, GOOGLE_CONFIG[:"#{Rails.env}"]['client_id'], GOOGLE_CONFIG[:"#{Rails.env}"]['client_secret'], { access_type: "online", approval_prompt: "" , prompt: 'consent'}
end