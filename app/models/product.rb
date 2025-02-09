class Product < ApplicationRecord
  has_many :cart_items
  has_many_attached :images  
  def soft_delete
    update(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end
end