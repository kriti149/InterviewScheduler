class DelivermailJob < ApplicationJob
  queue_as :default

  def perform(interview, choice)
    begin
      if Interview.find(interview.id)
        if (choice == 'schedule') 
          InterviewMailer.with(user_interview: interview).schedule.deliver_now
        end
        if (choice == 'reminder')
          InterviewMailer.with(user_interview: interview).reminder.deliver_now
        end
        if (choice == 'update')
          InterviewMailer.with(user_interview: interview).update.deliver_now
        end
      end
    rescue => exception

    end
  end
end
