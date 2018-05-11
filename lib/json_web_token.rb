class JsonWebToken
  class << self
    def encode(payload, exp = 12.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
    end

    def decode(token)
      decoded_token = JWT.decode token, Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' }
      decoded_token[0]['id']
    end
  end
end
