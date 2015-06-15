class AddReminderFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :ceremonies, :is_reminder_on_one_day_prior, :boolean, default: false
    add_column :ceremonies, :is_reminder_on_three_day_prior, :boolean, default: false
    add_column :ceremonies, :is_reminder_on_seven_day_prior, :boolean, default: false
  end
end
