class Interview < ApplicationRecord
	has_many :users, as: :interviewer 
    has_many :users, as: :candidate 
end
