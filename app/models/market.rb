class Market < ActiveRecord::Base
    has_many :categories
    has_many :devices

    def to_json
      {code: self.code, name: self.name}
    end
end
