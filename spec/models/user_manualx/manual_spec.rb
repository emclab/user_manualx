require 'rails_helper'

module UserManualx
  RSpec.describe Manual, type: :model do
    it "should be OK" do
      c = FactoryGirl.build(:user_manualx_manual)
      expect(c).to be_valid
    end
    
    it "should take nil subject" do
      c = FactoryGirl.build(:user_manualx_manual, :subject => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject nil content" do
      c = FactoryGirl.build(:user_manualx_manual, :content => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject duplidate subject" do
      p = FactoryGirl.create(:user_manualx_manual, :subject => 'test')
      p1 = FactoryGirl.build(:user_manualx_manual, :subject => 'Test')
      expect(p1).not_to be_valid
    end
  end
end
