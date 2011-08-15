if Rails.version == '2.3.11'
  module ActionController
    class Request
      def reset_session
        session.destroy if session && session.respond_to?(:destroy)
        self.session = {}
      end
    end
  end
end

