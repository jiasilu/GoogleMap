class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.deliver_confirm(user, sent_at = Time.now)
  end
end
