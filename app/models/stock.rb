class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:public_key],
      endpoint: 'https://finance-tracker-1993.iex.cloud/v1/'
    )
    new(ticker: ticker_symbol, name: client.quote(ticker_symbol).company_name, last_price: client.quote(ticker_symbol).latest_price)
  end
end


#  how to get price > client.quote(ticker_symbol).latest_price
