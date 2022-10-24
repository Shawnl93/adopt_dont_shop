class ApplicationController < ActionController::Base
  def welcome
  end

  private

  def error_message(errors)
    a = errors.full_messages.join(', ')
  end
end
