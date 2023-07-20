class Stock < ApplicationRecord

  def self.new_lookup(stock_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iexcloud[:public_key],
      secret_token: Rails.application.credentials.iexcloud[:secret_key],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    client.price(stock_symbol)
  end
end
