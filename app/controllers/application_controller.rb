class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include MessageAction

  after_action :add_messages_into_flash

  private

  def add_messages_into_flash
    add_into_flash :messages, messages
  end

  def add_into_flash(key, value)
    flash[key] = value
  end
end
