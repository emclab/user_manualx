require_dependency "user_manualx/application_controller"

module UserManualx
  class ManualsController < ApplicationController
    before_action :require_employee
    
    def index
      @title = t('Subjects')
      @manuals = params[:user_manualx_manuals][:model_ar_r]
      @manuals = @manuals.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('manual_index_view', 'user_manualx')
    end
  
    def new
      @title = t('New Subject')
      @manual = UserManualx::Manual.new()
      @erb_code = find_config_const('manual_new_view', 'user_manualx')  
    end
  
    def create
      @manual = UserManualx::Manual.new(params[:manual], :as => :role_new)
      @manual.submited_by_id = session[:user_id]
      @manual.last_updated_by_id = session[:user_id]
      if @manual.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @erb_code = find_config_const('manual_new_view', 'user_manualx')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Subject')
      @manual = UserManualx::Manual.find_by_id(params[:id])
      @erb_code = find_config_const('manual_edit_view', 'user_manualx')
    end
  
    def update
      @manual = UserManualx::Manual.find_by_id(params[:id])
      @manual.last_updated_by_id = session[:user_id]
      if @manual.update_attributes(params[:manual], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @erb_code = find_config_const('manual_edit_view', 'user_manualx')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
  
    def show
      @title = t('Subject Info')
      @manual = UserManualx::Manual.find_by_id(params[:id])
      @erb_code = find_config_const('manual_show_view', 'user_manualx')
    end
  end
end
