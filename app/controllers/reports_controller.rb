class ReportsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_admin!, only: [:index, :destroy]
    
  def new
    @report = Report.new
  end
  
  def create
    @report = Report.new(report_params)
    if @report.save
      flash[:success] = "Report sent!"
      redirect_to new_report_path
    else
      flash[:danger] = @report.errors.full_messages.join(", ")
      redirect_to new_report_path, notice: "Error occured, please try again."
    end
  end
  
  def index
    @reports = Report.all.paginate(:page => params[:page], :per_page => 20)
  end
  
  def destroy
    Report.find(params[:id]).destroy
    flash[:success] = "Report deleted."
    redirect_to reports_path
  end
  
  private
  
  def report_params
    params.require(:report).permit(:name, :issue, :body)
  end
    
end