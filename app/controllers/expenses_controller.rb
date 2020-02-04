class ExpensesController < ApplicationController

require 'date'
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
  end


  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to expenses_path, success:'記録しました'
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
      redirect_to expense_path
    else
      render 'edit'
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
  redirect_to expenses_path
  end

  private
  def expense_params
    params.require(:expense).permit(:category,:money,:month,:date)
  end
end
