class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }

  after_commit :invalidate_cache

  private

  def invalidate_cache
    Rails.cache.delete(UsersController::USERS_CACHE_KEY)
  end
end
