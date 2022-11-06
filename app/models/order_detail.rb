class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: {cannot: 0, waiting: 1, manufacture: 2, complete: 3}
end
