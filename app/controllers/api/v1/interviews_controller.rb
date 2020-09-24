module Api
    module V1
        class InterviewsController < ApplicationController
            before_action :getparticipants, only: [:new, :edit, :create, :update]
            before_action :getinterview, only: [:show, :edit, :update, :destroy]

            def index
                @interviews = Interview.all
                @user = User.all
                render json: @interviews
            end
    
            def show
                render json: @interview
            end

            def new
                @interview = Interview.new
            end
    
            def edit
            end

            def create
                @interview = Interview.new(interview_params)
                if @interview.save
                    render json: @interview
                else
                    render json: {status: 'ERROR', message: 'Interview Not Saved '}, status: :unprocessable_entity
                end
            end
    
            def update
                interviewer = @interview.interviewer_id
                candidate = @interview.candidate_id
                if @interview.update(interview_params)                         
                    render json: @interview
                else
                    render json: {status: 'ERROR', message: 'Interview Not Updated '}, status: :unprocessable_entity
                end
            end

            def destroy
                @interview.destroy
                render json: {status: 'SUCCESS', message: 'Interview Deleted Successfully '}, status: :ok
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

    end

end
