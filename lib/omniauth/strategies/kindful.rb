require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Kindful < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://www.kindful.com',
        :authorize_url => 'http://app.lvh.me:3000/admin/oauth2/authorize',
        :token_url => 'http://app.lvh.me:3000/admin/oauth2/token',
        :details_url => 'http://app.lvh.me:3000/admin/oauth2/api/v1/details'
      }

      def request_phase
        super
      end

      def query_string
        ''
      end

      info do
        {
          first_name: raw_info['first_name'],
          last_name: raw_info['last_name'],
          email: raw_info['email'],
          organization: raw_info['organization']
        }
      end

      def raw_info
        @raw_info || access_token.get(options['client_options']['details_url']).parsed
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

    end
  end
end
