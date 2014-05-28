require 'active_record'

ActiveRecord::Base.class_eval do
  class << self
    def symbol
      self.name.underscore.to_sym
    end

    def update_or_create(where_attributes = {}, &block)
      found = self.find_or_create_by(where_attributes)
      yield(found)
      found.save
      found
    end
  end
end

ActiveRecord::Relation.class_eval do
  def target_class_symbol
    self.symbol
  end

  def update_or_create(where_attributes = {}, &block)
    found = self.find_or_create_by(where_attributes)
    yield(found)
    found.save
    found
  end
end
