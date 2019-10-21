require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Kindful < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = "basic data_add data_append data_query"

      option :client_options, {
        :site => 'https://www.kindful.com',
        :authorize_url => 'https://app.kindful.com/admin/oauth2/authorize',
        :token_url => 'https://app.kindful.com/admin/oauth2/token',
        :details_url => 'https://app.kindful.com/admin/oauth2/api/v1/details'
      }

      option :environment, 'production'

      def setup_phase
        if options.environment == 'development' || options.environment == 'test'
          options.client_options.authorize_url = 'http://app.lvh.me:3000/admin/oauth2/authorize'
          options.client_options.token_url = 'http://app.lvh.me:3000/admin/oauth2/token'
          options.client_options.details_url = 'http://app.lvh.me:3000/admin/oauth2/api/v1/details'
        elsif options.environment == 'staging'
          options.client_options.authorize_url = 'https://app.trail-staging.us/admin/oauth2/authorize'
          options.client_options.token_url = 'https://app.trail-staging.us/admin/oauth2/token'
          options.client_options.details_url = 'https://app.trail-staging.us/admin/oauth2/api/v1/details'
        elsif options.environment == 'qa'
          options.client_options.authorize_url = 'https://app.kindqa.com/admin/oauth2/authorize'
          options.client_options.token_url = 'https://app.kindqa.com/admin/oauth2/token'
          options.client_options.details_url = 'https://app.kindqa.com/admin/oauth2/api/v1/details'
        elsif options.environment == 'playground'
          options.client_options.authorize_url = 'https://app-playground.kindful.com/admin/oauth2/authorize'
          options.client_options.token_url = 'https://app-playground.kindful.com/admin/oauth2/token'
          options.client_options.details_url = 'https://app-playground.kindful.com/admin/oauth2/api/v1/details'
        end

        super
      end

      def query_string
        ''
      end

      uid { raw_info['organization']['id'] }

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
          params[:scope] ||= DEFAULT_SCOPE
        end
      end

    end
  end
end

OmniAuth.config.failure_raise_out_environments = []
