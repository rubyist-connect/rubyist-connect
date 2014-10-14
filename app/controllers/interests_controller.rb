class InterestsController < ApplicationController
  before_action :set_interest, only: [ :show, :edit, :destroy, :update ]
  def index
    @interests = Interest.all
  end

  def show
  end

  def edit
  end

  def new
    @user = User.find(session[:user_id])
    @interest = @user.interests.build
  end

  def create
    @user = User.find(session[:user_id])
    @interest = @user.interests.build(interest_params)
    respond_to do |format|
      if @interest.save
        format.html { redirect_to @interest, notice: 'Tag was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @interest.update(interest_params)
        format.html { redirect_to @interest, notice: 'Tag was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @interest.destroy
    respond_to do |format|
      format.html { redirect_to interests_path , notice: 'Tag was successfully destroyed.' }
    end
  end

  private

    def set_interest
      @interest = Interest.find(params[:id])
    end

    def interest_params
      params.require(:interest).permit(:user_id, :content, :content_url)
    end
end
