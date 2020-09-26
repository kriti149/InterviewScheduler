class RemoveinterviewDatefromInterview < ActiveRecord::Migration[6.0]
  def change
  	remove_column :interviews, :interview_date, :date
  end
end
