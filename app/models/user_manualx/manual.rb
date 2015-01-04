module UserManualx
  class Manual < ActiveRecord::Base
    attr_accessor :category_name, :last_updated_by_name, :submitted_by_name, :sub_category_name
    attr_accessible :category_id, :content, :last_updated_by_id, :sub_category_id, :subject, :submited_by_id,
                    :as => :role_new
    attr_accessible :category_id, :content, :sub_category_id, :subject,
                    :category_name, :sub_category_name, :submited_by_name, 
                    :as => :role_update
                    
    attr_accessor :start_date_s, :end_date_s, :submited_by_id_s, :subject_s, :category_id_s, :sub_category_id_s

    attr_accessible :start_date_s, :end_date_s, :submited_by_id_s, :subject_s, :category_id_s, :sub_category_id_s,
                    :as => :role_search_stats
                    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :submited_by, :class_name => 'Authentify::User'
    belongs_to :category, :class_name => UserManualx.category_class.to_s
    belongs_to :sub_category, :class_name => UserManualx.sub_category_class.to_s
       
    validates :subject, :content, :presence => true
    validates :subject, :uniqueness => {:case_sensitive => false, :message => 'Duplicate Subject!'} 
    validates :submited_by_id, :numericality => {:only_integer => true, :greater_than => 0}
    validates :category_id, :numericality => {:only_integer => true, :greater_than => 0}, :if => 'category_id.present?'
    validates :sub_category_id, :numericality => {:only_integer => true, :greater_than => 0}, :if => 'sub_category_id.present?'
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_manual', 'user_manualx')
      eval(wf) if wf.present?
    end        
  end
end
