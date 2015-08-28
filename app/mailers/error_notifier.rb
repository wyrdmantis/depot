class ErrorNotifier < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_notifier.notify_error.subject
  #
  def notify_error(error)
    @error = error

    mail to: "admin@example.org", subject: "Depot App Error"
  end
end
