class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  require 'pry'

  protected

  def render_flash type, message
    render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash", locals: { msg_type: type, message: message })
  end
end
