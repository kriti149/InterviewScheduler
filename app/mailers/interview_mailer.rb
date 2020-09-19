class InterviewMailer < ApplicationMailer
	before_action :set_interviews, only: [:schedule, :update, :reminder]
    default from: 'notifications@example.com'
    def schedule
        mail(to: @candidate.email, subject: 'Interview has been scheduled')
        mail(to: @interviewer.email, subject: 'Interview has been scheduled')
    end
    def update
        mail(to: @candidate.email, subject: 'Interview has been updated')
        mail(to: @interviewer.email, subject: 'Interview has been updated')
    end
    def reminder
        mail(to: @candidate.email, subject: 'Reminder for the interview')
        mail(to: @interviewer.email, subject: 'Reminder for the interview')
    end
    private
        def set_interviews
            @user = params[:user_interview]
            @candidate = User.find(@user.candidate_id)
            @interviewer = User.find(@user.interviewer_id)
            @url  = 'http://example.com/login'
        end
end
