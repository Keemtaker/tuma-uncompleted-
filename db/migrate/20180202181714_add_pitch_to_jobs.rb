class AddPitchToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :pitch, :text
  end
end
