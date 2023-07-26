class StocksController < ApplicationController
  
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.turbo_stream { render 'users/result', locals: { stock: @stock } }
        end
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash", locals: { msg_type: :error, message: "#{params[:stock]} is not a valid stock symbol" })
          end
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render_flash(:alert, "Please enter a symbol to search")
          # render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash", locals: { msg_type: :alert, message: "Please enter a symbol to search" })
        end
      end
    end
  end
end