class DashboardController < ApplicationController
  include Authentication
  include ActionView::Helpers::UrlHelper
  def index
    all_logs = PaperTrail::Version.where.not(whodunnit: nil).order(created_at: :desc)
    @logs = sort_logs(all_logs)
  end

  private

  def sort_logs(unsorted_logs)
    unsorted_logs.map do |record|
      case record[:event]
        when 'Login User'
          {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} Logged In"}
        when 'Logout User'
          {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} Logged Out"}
        when 'Register User'
          {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} was Registered"}
        when 'Archive User'
          user_data = User.find(record.item_id)
          {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} archived User \"#{user_data.username}\""}
        when 'Approve User'
          user_data = User.find(record.item_id)
          {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} approve User \"#{user_data.username}\""}
        when -> (tmp) { tmp.starts_with?("Set User Role") }
          user_data = User.find(record.item_id)
          role = record[:event].split(",",2).last
          {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} set User \"#{user_data.username}\" role to \"#{role}\""}
        when 'Create Dog'
          dog_data = Dog.find(record.item_id)
          log_string = ""
          if dog_data.archived?
            log_string = "<div class='d-inline-block'>#{dog_data.uuid}</div>"
          else
            log_string = "<div class='d-inline-block'>#{link_to dog_data.uuid, dog_path(dog_data.uuid)}</div>"
          end
          {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} created Dog Profile ID: #{log_string}"}
        when 'Archive Dog'
          dog_data = Dog.find(record.item_id)
          {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} archived Dog Profile ID: <div class='d-inline-block'>#{dog_data.uuid}</div>"}
        when 'Update Dog'
          dog_data = Dog.find(record.item_id)
          log_string = ""
          if dog_data.archived?
            log_string = "<div class='d-inline-block'>#{dog_data.uuid}</div>"
          else
            log_string = "<div class='d-inline-block'>#{link_to dog_data.uuid, dog_path(dog_data.uuid)}</div>"
          end
          {log_text: "#{record.created_at.localtime.strftime('%b %d, %Y %I:%M %p')}: User #{record.whodunnit} updated Dog Profile ID: #{log_string}"}
        else 
          {log_text: "Event: #{record[:event]}"}
      end
    end
  end
end
