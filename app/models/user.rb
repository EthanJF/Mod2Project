class User < ApplicationRecord
    has_many :stock_picks
    has_many :stocks, through: :stock_picks

    has_many :battles_as_player1, foreign_key: :player1_id, class_name: "Battle", dependent: :destroy
    has_many :player2s, through: :battles_as_player1, source: :player2

    has_many :battles_as_player2, foreign_key: :player2_id, class_name: "Battle", dependent: :destroy
    has_many :player1s, through: :battles_as_player2, source: :player1

    has_secure_password

    validates :name, presence: true
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :wealth, presence: true, numericality: true
    validates :about_me, presence: true
    validates :photo_url, presence: true


    def most_stock
      
    end


    def all_battles
      self.battles_as_player1 + self.battles_as_player2
    end


    def battles_won
      self.all_battles.select {|battle| battle.winner == self}
    end

    def battles_lost
      self.all_battles.select {|battle| battle.loser == self}
    end


    def total_worth
      self.stocks.reduce(0) {|sum, stock| sum + stock.current_value}
    end

    def best_stock
      # tried adding a conditional for the user without
        self.stocks.max_by { |stock| stock.current_value}
    end


end
