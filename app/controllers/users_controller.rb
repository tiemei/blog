class UsersController < ApplicationController

  # GET /users/new
  def new
    @user = User.new
    @user.name = '请输入名字'
    @user.pwd  = '请输入密码'
    @user.email = '请输入邮箱'
  end
  
  # POST /users
  def create
    @user = User.new(params[:user])

    if @user.save
      render 'login'
    else
      render 'new' # 不用redirect_to :back的原因是，这么做原来填写的表单字段保留
    end
  end
  
  # POST /login
  # POST /login.json
  def login
    redirect_to session[:current_user] and return if session[:current_user]

    @user = User.new(params[:user])

    # TODO 这大段的逻辑应该放在Controler还是Model中合适?
    if @user.pwd.blank? || @user.name.blank?
      flash[:notice] = "账户名和密码不能为空"
    else
      user = User.find_by_name(@user).first
      if user && ( @user.pwd == user.pwd )
        session[:current_user] = user
        redirect_to session[:current_user] and return
      else 
        flash[:notice] = '用户名或密码错误'
      end
    end
    flash.now # only avaliable in this request
  end

  def show 

  end
    
  def index
  end
end
