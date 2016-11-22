class UserAdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :verify_is_admin , only: [:new, :create]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    redirect_to :controller => 'user_admin', :action => 'index' unless @user.id == current_user.id
  end
  
  # PATCH/PUT /user/1
  # PATCH/PUT /user/1.json
  def update
    @user = User.find_by_id params[:id]
    respond_to do |format|
      if @user.update_with_password(user_params_with_pass)
        format.html { redirect_to :controller => 'user_admin', :action => 'show',  notice: 'El usuario se modifico correctamente.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /canchas/1
  # DELETE /canchas/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to :controller => 'user_admin', :action => 'index' , notice: 'El usuario se elimino correctamente.' }
      format.json { head :no_content }
    end
  end


  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin)
    end
    
    def user_params_with_pass
      params.require(:user).permit(:email, :password, :password_confirmation, :admin, :current_password)
    end
    
    def verify_is_admin
       unless current_user && current_user.admin?
         redirect_to :controller => 'welcome', :action => 'index' 
       end
    end
    
end
