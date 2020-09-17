class InterviewsController < ApplicationController
	before_action :getparticipants, only: [:new, :edit, :create, :update]
    before_action :getinterview, only: [:show, :edit, :update]

    def index
        @interview = Interview.all
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
            redirect_to @interview, notice: "Interview successfully created!"
        else
            render 'new'
        end
    end
    
    def update
        interviewer = @interview.interviewer_id
        candidate = @interview.candidate_id
        if @interview.update(interview_params)        
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
        @candidate = User.where("usertype = :usertype" , {usertype: "candidate"})
        @interviewer = User.where("usertype = :usertype" , {usertype: "interviewer"})
    end

    def getinterview
        @interview = Interview.find(params[:id])
    end

    def interview_params
        params.require(:interview).permit(:role, :interview_date, :start_time, :end_time, :interviewer_id, :candidate_id)
    end

end
