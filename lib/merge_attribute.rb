module MergeAttribute
  def merge_attribute (attribute, old, new)
    if old.nil?
      attribute << new
    else
      old.update_attributes (new.attributes.reject! {|k, v| v.nil?})
    end
  end
end
