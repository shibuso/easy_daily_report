class ReportMailer < ApplicationMailer
  default from: Settings.mail.from
  default to: Settings.mail.to

  def send_report(report)
    @report = report
    date = I18n.l(report.target_date, format: :long)
    subject = "【日報】#{date} #{report.user.name}"
    reply_to = [Settings.mail.from, @report.user.email]
    mail(subject: subject, reply_to: reply_to)
  end
end
