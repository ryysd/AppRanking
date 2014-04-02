class Category < ActiveRecord::Base
  has_many :app_items
  has_many :sub_categories, class_name: :Category, foreign_key: :category_id
  belongs_to :parent_category, class_name: :Category, foreign_key: :category_id
  belongs_to :market

  scope :market_unique_name, lambda {|name, market_id| where(['name = ? and market_id = ?', name, market_id])}

  def to_json
    {code: self.code, name: self.name}
  end

  def parents
    if @parents.nil?
      @parents = self.parent_category.nil? ? [] : self.parent_category.parents
      @parents.push self
    end

    @parents
  end

  def childs
    if @childs.nil?
      @childs = self.sub_categories.nil? ? [] : self.sub_categories.map{|child| child.childs}.flatten
      @childs.push self
    end

    @childs
  end
end
