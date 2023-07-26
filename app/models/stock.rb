class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(stock_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iexcloud[:public_key],
      secret_token: Rails.application.credentials.iexcloud[:secret_key],
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    begin
      new(
        ticker: stock_symbol, 
        name: client.company(stock_symbol).company_name, 
        last_price: client.price(stock_symbol)
      )
    rescue => e
      return nil
    end
  end
end
