class Credential
  def self.google_client_id
    ENV['GOOGLE_AUTH_CLIENT_ID'] || Rails.application.credentials.google[:client_id]
  end

  def self.google_client_secret
    ENV['GOOGLE_AUTH_CLIENT_SECRET'] || Rails.application.credentials.google[:client_secret]
  end
end
