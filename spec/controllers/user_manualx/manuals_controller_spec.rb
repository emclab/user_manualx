require 'rails_helper'

module UserManualx
  RSpec.describe ManualsController, type: :controller do
    routes {UserManualx::Engine.routes}
    before(:each) do
      #expect(controller).to receive(:require_signin)
      expect(controller).to receive(:require_employee)
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
    end
    
    before(:each) do
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      @qs = FactoryGirl.create(:commonx_misc_definition, :for_which => 'manual_category', :active => true)
      
      session[:user_role_ids] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id).user_role_ids
    end
    
    render_views
  
    describe "GET 'index'" do
      it "should return manuals" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "UserManualx::Manual.order('id')")
        session[:user_id] = @u.id
        sup = FactoryGirl.create(:user_manualx_manual, :category_id => @qs.id)
        get 'index'
        expect(assigns(:manuals)).to match_array([sup])
      end
    end
  
    describe "GET 'new'" do
      it "should display the new page" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        get 'new'
        expect(response).to be_success
      end
    end
  
    describe "GET 'create'" do
      it "should create a new record" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        sup = FactoryGirl.attributes_for(:user_manualx_manual)
        get 'create', {:manual => sup}
        expect(response).to redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render new with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        sup = FactoryGirl.attributes_for(:user_manualx_manual, :subject => nil)
        get 'create', {:manual => sup}
        expect(response).to render_template('new')
      end
    end
  
    describe "GET 'edit'" do
      it "returns render edit page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        sup = FactoryGirl.create(:user_manualx_manual)
        get 'edit', {:id => sup.id}
        expect(response).to be_success
      end
            
    end
  
    describe "GET 'update'" do
      
      it "returns updated page" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        sup = FactoryGirl.create(:user_manualx_manual)
        get 'update', {:id => sup.id, :manual => {:subject => 'a new name'}}
        expect(response).to redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render edit with data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        sup = FactoryGirl.create(:user_manualx_manual)
        get 'update', {:id => sup.id, :manual => {:subject => ''}}
        expect(response).to render_template('edit')
      end
    end
  
    describe "GET 'show'" do
      it "should show" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource => 'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
        session[:user_id] = @u.id
        sup = FactoryGirl.create(:user_manualx_manual, :last_updated_by_id => session[:user_id], :category_id => @qs.id)
        get 'show', {:id => sup.id}
        expect(response).to be_success
      end
    end  
  end
end
