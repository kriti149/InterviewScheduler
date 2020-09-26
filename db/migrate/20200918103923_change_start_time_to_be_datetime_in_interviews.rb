class ChangeStartTimeToBeDatetimeInInterviews < ActiveRecord::Migration[6.0]
  def change
  	change_column :interviews, :start_time, :datetime
  end
end
