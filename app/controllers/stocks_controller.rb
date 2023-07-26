class StocksController < ApplicationController
  
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          # format.js { render partial: "users/result" }
          format.turbo_stream { render 'users/result', locals: { stock: @stock } }
        end
        # render "users/my_portfolio"
      else
        flash[:alert] = "#{params[:stock]} is not a valid stock symbol"
        redirect_to my_portfolio_path
      end
    else
      flash[:alert] = "Please enter a symbol to search"
      redirect_to my_portfolio_path
    end
  end

end