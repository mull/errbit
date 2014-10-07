if defined? Sqwiggle
  class NotificationServices::SqwiggleService < NotificationService
    Label = "sqwiggle"

    Fields += [
      [:api_token, {
        :placeholder => 'Sqwiggle API client token',
        :label => 'Token'
      }],
      [:room_id, {
        :placeholder => 'Lobby',
        :label => 'Sqwiggle stream to send messages to'
      }]
    ]

    def check_params
      if Fields.detect {|f| self[f[0]].blank?  }
        errors.add :base, 
        """You must specify an API token and a stream name"""
      end
    end

    def build_message(problem)
      "[#{ problem.environment }][#{ problem.where }] #{problem.message.to_s}: #{problem_url(problem)}"
    end

    def create_notification(problem)
      client = Sqwiggle.client(api_token)
      message = client.messages.new(room_id: room_id, text: build_message(problem))
      message.save
    end
  end
end
