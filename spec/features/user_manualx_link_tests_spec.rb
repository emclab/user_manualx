require 'spec_helper'

describe "LinkTests" do
  describe "GET /user_manualx_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      @qs = FactoryGirl.create(:commonx_misc_definition, :for_which => 'manual_category')
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "UserManualx::Manual.order('created_at DESC')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'user_manualx_manuals', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login' 
    end
    it "works! (now write some real specs)" do
      sup = FactoryGirl.create(:user_manualx_manual, :category_id => @qs.id)
      visit manuals_path
      save_and_open_page
      page.should have_content('Subjects')
      #show
      click_link sup.subject    
      page.should have_content('Subject Info')
       
      visit manuals_path   
      click_link 'Edit'
      save_and_open_page
      page.should have_content('Update Subject')
      fill_in :manual_subject, :with => 'a new subject'
      click_button 'Save'
      visit manuals_path
      page.should have_content('a new subject')
      #bad subject
      click_link 'Edit'
      fill_in :manual_subject, :with => ''
      fill_in :manual_content, :with => 'a bad subject'
      visit manuals_path
      page.should_not have_content('a bad subject')
      
      visit manuals_path
      #save_and_open_page
      click_link "New Subject"
      #save_and_open_page
      page.should have_content('New Subject')
      fill_in :manual_subject, :with => 'create a new subject'
      fill_in :manual_content, :with => 'create a new content'
      click_button 'Save'
      visit manuals_path
      page.should have_content('create a new subject')
      #bad create
      visit manuals_path
      click_link 'New Subject'
      fill_in :manual_subject, :with => 'create bad new subject'
      fill_in :manual_content, :with => ''
      click_button 'Save'
      visit manuals_path
      page.should_not have_content('create bad new subject')
    end
  end
end
