class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :validatable

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def self.search(param)
    param.strip!
    search_results = (matches("first_name", param) + matches("last_name", param) + matches("email", param)).uniq
    return nil unless search_results
    search_results
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like lower(?)", "%#{param}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friends_with?(id_of_friend)
    !self.friends.where(id: id_of_friend).exists?
  end
end
