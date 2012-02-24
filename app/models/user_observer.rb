class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.confirm(user, sent_at = Time.now)
  end
end
