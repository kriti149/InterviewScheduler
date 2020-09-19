class InterviewsController < ApplicationController
	before_action :getparticipants, only: [:new, :edit, :create, :update]
    before_action :getinterview, only: [:show, :edit, :update, :destroy]

    def index
        @interviews = Interview.all
        @user = User.all
    end
    
    def show
    end

    def new
        @interview = Interview.new
    end
    
    def edit
    end

    def create
        @interview = Interview.new(interview_params)
        if @interview.save
        	InterviewMailer.with(user_interview: @interview).schedule.deliver_later
            scheduledtime = @interview.start_time - 5.hours - 30.minutes - 30.minutes
            if (scheduledtime < Time.now)
                scheduledtime = scheduledtime + 30.minutes
            end
            InterviewMailer.with(user_interview: @interview).reminder.deliver_later!(wait_until: scheduledtime)
            redirect_to @interview, notice: "Interview successfully created!"
        else
            render 'new'
        end
    end
    
    def update
        interviewer = @interview.interviewer_id
        candidate = @interview.candidate_id
        if @interview.update(interview_params)
            InterviewMailer.with(user_interview: @interview).update.deliver_later        
            redirect_to @interview, notice: "Interview successfully updated!"
        else
            render 'edit'
        end
    end

    def destroy     
        @interview.destroy
        redirect_to interviews_path, notice: "Interview successfully deleted!"
    end
       
    private

    def getparticipants
        @candidate = User.where("participation = :participation" , {participation: "candidate"})
        @interviewer = User.where("participation = :participation" , {participation: "interviewer"})
    end

    def getinterview
        @interview = Interview.find(params[:id])
    end

    def interview_params
        params.require(:interview).permit(:role, :start_time, :end_time, :interviewer_id, :candidate_id, :resume)
    end

end
