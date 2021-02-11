class ApplicationMailer < ActionMailer::Base
  FROM_ADDRESS = "noreply@rubyist.co".freeze
  def self.from_text
    address = Mail::Address.new FROM_ADDRESS
    address.display_name = "Rubyist Connect"
    address.format
  end

  default from: from_text
end
