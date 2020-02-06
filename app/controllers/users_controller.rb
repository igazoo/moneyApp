class UsersController < ApplicationController
  before_action :logged_in_user,only:[:expense_index]
  def expense_index
    @user = User.find(params[:id])
    @expenses= Expense.where(user_id: @user.id)
    @graf ={'食事'=>0, '飲み会'=>0,'買い物'=>0,'遊び'=>0,'デート'=>0,'その他'=>0}
    @expenses.each do |expense|
      if expense.category =='食事'
        @graf['食事']+=expense.money
      elsif expense.category =='飲み会'
        @graf['飲み会']+=expense.money
      elsif expense.category =='買い物'
        @graf['買い物']+=expense.money
      elsif expense.category =='遊び'
        @graf['遊び']+=expense.money
      elsif expense.category =='デート'
        @graf['デート']+=expense.money
      elsif expense.category =='その他'
        @graf['その他']+=expense.money
      end
    end

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to new_expense_path, success: '登録しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end


  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

end
