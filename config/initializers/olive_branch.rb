class FastCamel
  def self.camel_cache
    @camel_cache ||= {}
  end

  def self.camelize(string)
    camel_cache[string] ||= string.underscore.camelize(:lower)
  end
end

Rails.application.config.middleware.use OliveBranch::Middleware, camelize: FastCamel.method(:camelize)