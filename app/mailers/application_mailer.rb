class ApplicationMailer < ActionMailer::Base
  def self.from_text
    address = Mail::Address.new "noreply@rubyist.co"
    address.display_name = "Rubyist Connect"
    address.format
  end

  default from: from_text
end
