class Interview < ApplicationRecord
	has_many :users, as: :interviewer 
    has_many :users, as: :candidate
    has_one_attached :resume
    validates :role, presence: true,
                    length: { minimum: 2 }
    validates :resume, presence: true
    validate :correct_resume_type
    validate :validate_time
    validate :validate_time_overlapping
end

def correct_resume_type
    if resume.attached? && !resume.content_type.in?(%w(application/msword application/pdf))
      errors.add(:Resume, 'must be a PDF or a DOC file')
    end
end

def validate_time
     if self.start_time == nil or self.end_time == nil
     	errors.add(:Time_cannnot_be_blank, ":ENTER SOME VALUE" )
     
     else
     	if self.start_time < Time.now or self.end_time < Time.now
     		errors.add(:Invalid_Date, ":SELECT DATE IN THE PRESENT")
     	end

	 	if self.start_time > self.end_time
        	errors.add(:Invalid_Time, ":SELECT END TIME GREATER THAN START TIME")
    	end

	 	if (self.end_time - self.start_time) < 30.minutes
        	errors.add(:OOPS_very_short_duration_for_interview, ":SHORT DURATION, PLEASE EXTEND END TIME")
     	end

     	if (self.end_time - self.start_time) > 90.minutes
        	errors.add(:OOPS_very_long_duration_for_interview, ":LONG DURATION, PLEASE REDUCE END TIME")
     	end 
     end
end

def validate_time_overlapping
	interviewers = Interview.where(interviewer_id: self.interviewer_id)
    interviewers.each do |interviewer|
        start_time = interviewer.start_time
        end_time = interviewer.end_time
        if !self.start_time.nil? and !self.end_time.nil?
            if ((start_time <= self.start_time  and end_time >= self.end_time) or (start_time >= self.start_time  and start_time <= self.end_time) or (end_time >= self.start_time  and end_time <= self.end_time) or(start_time >= self.start_time  and end_time <= self.end_time))
                errors.add(:Interview_cannot_be_scheduled, ":INTERVIEWER IS IN ANOTHER INTERVIEW")
        	end
        end
    end
	candidates = Interview.where(candidate_id: self.candidate_id)
    candidates.each do |candidate|
        start_time = candidate.start_time
        end_time = candidate.end_time
        if !self.start_time.nil? and !self.end_time.nil?
            if ((start_time <= self.start_time  and end_time >= self.end_time) or (start_time >= self.start_time  and start_time <= self.end_time) or (end_time >= self.start_time  and end_time <= self.end_time) or(start_time >= self.start_time  and end_time <= self.end_time))
                errors.add(:Interview_cannot_be_scheduled, ":CANDIDATE IS IN ANOTHER INTERVIEW")
        	end
        end
    end
end
