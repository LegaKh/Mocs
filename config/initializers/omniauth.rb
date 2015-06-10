OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '794487273981506', '65891f5d6c92212c9a0723ba7afd249a'
end
