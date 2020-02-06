class ExpensesController < ApplicationController


  def index
    @expenses = Expense.all
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


  def show
    @expenses = Expense.all
    @expense = Expense.find(params[:id])
    @graf2={'食事'=>0, '飲み会'=>0,'買い物'=>0,'遊び'=>0,'デート'=>0,'その他'=>0}
    @expenses.each do |expense|
      if expense.month == @expense.month
        if expense.category =='食事'
          @graf2['食事']+=expense.money
        elsif expense.category =='飲み会'
          @graf2['飲み会']+=expense.money
        elsif expense.category =='買い物'
          @graf2['買い物']+=expense.money
        elsif expense.category =='遊び'
          @graf2['遊び']+=expense.money
        elsif expense.category =='デート'
          @graf2['デート']+=expense.money
        elsif expense.category =='その他'
          @graf2['その他']+=expense.money
        end
      end
    end
  end


  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user_id= current_user.id
    if @expense.save
      redirect_to expense_index_user_path(current_user.id), success:'記録しました'
    else
      flash[:danger] ='記録できませんでした'
      render :new
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to expense_path,success:"編集しました"
    else
      flash[:danger] ="編集に失敗しました"
      render 'edit'
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to expenses_path,info:"データを削除しました"
  end

  private
  def expense_params
    params.require(:expense).permit(:category,:money,:month,:date)
  end

end
