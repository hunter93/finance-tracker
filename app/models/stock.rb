class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:public_key],
      endpoint: 'https://finance-tracker-1993.iex.cloud/v1/'
    )
    client.quote(ticker_symbol).latest_price
  end
end
