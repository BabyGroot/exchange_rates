Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Credential.google_client_id, Credential.google_client_secret
end
