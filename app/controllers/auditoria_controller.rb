class AuditoriaController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_is_admin
  
  def accesos
    @usuarios = User.all
  end

  def verify_is_admin
    unless current_user && current_user.admin?
      redirect_to :controller => 'welcome', :action => 'index'
    end
  end
  
end
