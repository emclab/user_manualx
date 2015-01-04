require "user_manualx/engine"

module UserManualx
  
  mattr_accessor :category_class, :sub_category_class
  
  def self.category_class
    @@category_class.constantize
  end
  
  def self.sub_category_class
    @@sub_category_class.constantize
  end
end
