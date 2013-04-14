# encoding: UTF-8
class UsersController < ApplicationController
  layout "login", :only => [:login, :new, :create]

  skip_before_filter :require_login, :only => [:login, :new, :create]
  before_filter :landed, :only => [:login, :new, :create]

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
      redirect_to '/login'
    else
      render 'new' # 不用redirect_to :back的原因是，这么做原来填写的表单字段保留
    end
  end
  
  # POST /login
  # POST /login.json
  # GET /login
  # GET /login.json
  def login
    redirect_to user_path(session[:current_user_id]) and return if session[:current_user_id]

    @user = User.new(params[:user])

    # TODO 这大段的逻辑应该放在Controler还是Model中合适?
    if @user.pwd.blank? || @user.name.blank?
      flash.now[:notice] = "账户名和密码不能为空"
    else
      user = User.find_by_name(@user).first
      if user && ( @user.pwd == user.pwd )
        session[:current_user] = user.attributes
        session[:current_user_id] = user.id
        redirect_to user_path(session[:current_user_id]) and return
      else 
        flash.now[:notice] = '用户名或密码错误'
      end
    end
  end
  
  # GET logout
  def logout
    session[:current_user], session[:current_user_id] = nil, nil
    redirect_to '/login'
  end

  def show 
    redirect_to '/articles'
  end
  
  # GET /users
  def index
  end

  private 
  def landed
    if session[:current_user_id]
      redirect_to "/articles"
    end
  end
end
