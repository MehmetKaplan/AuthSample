Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_MOCMON_Test1_ID'], ENV['FB_MOCMON_Test1_Secret']
end
