class ReservationInformation < ActiveRecord::Base
  include MergeAttribute

  has_one :bonus, autosave: true
  before_create :set_bonus

  attr_accessor :bonus_id, :os_type

  private
  def set_bonus
    unless self.bonus_id.empty?
      bonus = load_bonus
      add_or_update_bonus bonus
    end
  end

  def load_bonus
    detail = YoyakutoptenScraper::Bonus.new bonus_id: self.bonus_id, os_type: self.os_type.downcase.to_sym
    detail.update

    {
      image_url:   detail.img_url,
      description: detail.description,
    }
  end

  def add_or_update_bonus(bonus)
    new_bonus = Bonus.new bonus
    old_bonus = Bonus.find_by_reservation_id self.id

    old_bonus.nil? ? self.bonus = new_bonus : (update_valid_attributes old_bonus, new_bonus)
  end
end
