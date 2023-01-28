class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:public_key],
      endpoint: 'https://finance-tracker-1993.iex.cloud/v1/'
    )
    begin
      new(ticker: ticker_symbol, name: client.quote(ticker_symbol).company_name, last_price: client.quote(ticker_symbol).latest_price)
    rescue => exception
      return nil
    end
  end
end


#  how to get price > client.quote(ticker_symbol).latest_price
