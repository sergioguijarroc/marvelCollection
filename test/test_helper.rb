# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def stub_api_marvel
      mock_response = {
        data: {
          results: [
            {
              id: 1,
              name: 'Iron Man',
              description: 'He loves you 3000',
              thumbnail: {
                path: 'http://example.com/image',
                extension: 'jpg'
              }
            }
          ]
        }
      }

      stub_request(:get, 'https://gateway.marvel.com/v1/public/characters')
        .to_return(
          status: 200,
          body: mock_response.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      mock_response
    end
  end
end
