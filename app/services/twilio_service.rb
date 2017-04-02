require 'twilio-ruby'
class TwilioService

  def initialize(user)
    @user = user
  end

  def send_message
    client = Twilio::REST::Client.new(
            ENV['twillio_sid'],
            ENV['twillio_token']
            )

    client.messages.create(
            from: ENV['twillio_number'],
            to: @user.phone,
            body: @user.token
        )
  end
end
