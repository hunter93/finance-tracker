class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: 'pk_cedb8a9ca2214c9593cba8283101020f',
      endpoint: 'https://finance-tracker-1993.iex.cloud/v1/'
    )
    client.quote(ticker_symbol).latest_price
  end
end
