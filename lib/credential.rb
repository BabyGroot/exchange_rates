class Credential
  def self.google_client_id
    Rails.application.credentials.google[:client_id]
  end

  def self.google_client_secret
    Rails.application.credentials.google[:client_secret]
  end
end
