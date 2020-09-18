class ChangeEndTimeToBeDatetimeInInterviews < ActiveRecord::Migration[6.0]
  def change
  	change_column :interviews, :end_time, :datetime
  end
end
