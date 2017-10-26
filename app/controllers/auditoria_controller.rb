class AuditoriaController < ApplicationController
  before_filter :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_filter :verify_is_admin
  
  def accesos
    @usuarios = User.all
  end

  def modificaciones
    @auditoria = Auditorium.last(20).reverse
    @today = Date.today
  end

  def consulta
    date = params[:date].to_date
    user =  params[:user]
    @auditoria = [];
    @today = Date.today
    
    unless(user.empty?)
      @auditoria += Auditorium.where("usuario like ?", user)
    end

    unless(date.nil?)
      if(user.empty?)
        @auditoria += Auditorium.where("DATE(created_at) = ?", date)
      else
        @auditoria = Auditorium.where("usuario like ? AND DATE(created_at) = ?", user, date)
      end
    end

    if(user.empty? && date.nil?)
          redirect_to :controller => 'auditoria', :action => 'modificaciones'
    end

  end

  def verify_is_admin
    unless current_user && current_user.admin?
      redirect_to :controller => 'welcome', :action => 'index'
    end
  end
  
end
