class JobsController < ApplicationController

  def index
     @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @company = Company.find(params[:company_id])
    @job = @company.jobs.new
  end

  def create
    @job = Job.new(job_params)
    @company =  params[:company_id]
    @job.company_id = @company
    if @job.save
      redirect_to company_job_path(@company, @job)
    else
      render :new
    end
  end


  private

  def job_params
    params.require(:job).permit(:title, :description, :role, :requirements, :duties, :company_id)
  end
end