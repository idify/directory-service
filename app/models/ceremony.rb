class Ceremony < ActiveRecord::Base
  belongs_to :user

  def self.get_one_day_prior_events_list_for_sending_reminder_email
    one_day_prior_user_events = self.where("is_reminder_on_one_day_prior = ?", true)

    if one_day_prior_user_events.present?
      one_day_prior_user_events
    end
  end

  def self.get_three_day_prior_events_list_for_sending_reminder_email
    three_day_prior_user_events = self.where("is_reminder_on_three_day_prior = ?", true)

    if three_day_prior_user_events.present?
      three_day_prior_user_events
    end
  end

  def self.get_seven_day_prior_events_list_for_sending_reminder_email
    seven_day_prior_user_events = self.where("is_reminder_on_seven_day_prior = ?", true)

    if seven_day_prior_user_events.present?
      seven_day_prior_user_events
    end
  end

end