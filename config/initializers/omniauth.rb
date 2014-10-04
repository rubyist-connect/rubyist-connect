Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_CLIENT_ID'] || "f11237c6b02251033dea", ENV['GITHUB_SECRET'] || "48f3a84d6c5a89c4a017a550ac8aa880618bb26d"
end
