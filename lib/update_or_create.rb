require 'active_record'

ActiveRecord::Base.class_eval do
  class << self
    def symbol
      self.name.underscore.to_sym
    end

    def update_or_create(where_attributes = {}, update_attributes = {})
      self.find_or_create_by(where_attributes)
      self.update(update_attributes)
    end
  end
end

ActiveRecord::Relation.class_eval do
  def target_class_symbol
    self.symbol
  end

  def update_or_create(where_attributes = {}, update_attributes = {})
    all_where_attributes = attributes.merge(where_attributes)
    self.find_or_create_by(all_where_attributes)
    self.update(update_attributes)
  end
end
