require 'spec_helper'

module UserManualx
  describe Manual do
    it "should be OK" do
      c = FactoryGirl.build(:user_manualx_manual)
      c.should be_valid
    end
    
    it "should take nil subject" do
      c = FactoryGirl.build(:user_manualx_manual, :subject => nil)
      c.should_not be_valid
    end
    
    it "should reject nil content" do
      c = FactoryGirl.build(:user_manualx_manual, :content => nil)
      c.should_not be_valid
    end
    
    it "should reject duplidate subject" do
      p = FactoryGirl.create(:user_manualx_manual, :subject => 'test')
      p1 = FactoryGirl.build(:user_manualx_manual, :subject => 'Test')
      p1.should_not be_valid
    end
  end
end
