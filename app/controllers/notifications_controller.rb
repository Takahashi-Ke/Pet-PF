class NotificationsController < ApplicationController
  def index
    @pet = current_owner.pet
    @diary = Diary.new
    @notifications = @pet.passive_notifications.where.not(visitor_id: @pet.id).page(params[:page]).per(20)
    @notifications.where(is_checked: false).each do |notification|
      notification.update(is_checked: true)
    end
  end
end
