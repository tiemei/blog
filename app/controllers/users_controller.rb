class UsersController < ApplicationController

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to '/home'
    else
      render 'new'
    end
  end

  def update
    @user = User.new

  end

  def login
    puts 'one login come in!'
  end
end
