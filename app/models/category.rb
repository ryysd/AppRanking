class Category < ActiveRecord::Base
  def find_by_code (code)
    category = Category.find :first,
      :conditions => ['code = ?', category_code]

    raise ActiveRecord::RecordNotFound, "could not get category. category_code: #{category_code}" if category.nil?
    category
  end
end
