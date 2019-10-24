class StockPick < ApplicationRecord
  belongs_to :user
  belongs_to :stock

#

  # validate



  # validates :quantity, presence: true
  validate :check_quantity
  validate :check_balance



def check_balance
  # byebug
  if self.user.wealth < (self.stock.current_value * self.quantity)
    errors.add(:current_value, "You broke")
  end
end


def check_quantity
  if self.quantity == nil
    errors.add(:quantity, "Needs to be greater than 0")
  elsif self.quantity > self.stock.current_quantity
    errors.add(:quantity, "Not enough stock")
  end
end

  def update_stock
    if self.stock.current_quantity - self.quantity >= 0
    curr_quan = self.stock.current_quantity
    self.stock.update(current_quantity: curr_quan - self.quantity)
  end
end
# This should be a validation custom method
# def check_total
#   if self.stock.current_quantity - self.quantity >= 0
#
#   end

end
