class JobsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]

  def index
    @search = Job.ransack(params[:q])
    @jobs = @search.result(distinct: true).order("id DESC")
  end


  def new
    if current_user
      @company = Company.find(params[:company_id])
      @job = @company.jobs.new
    else
      @job = Job.new

    end
  end

  def create
    if current_user
      registered_job
    else
      quick_job
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    if current_user
      @company = Company.find(params[:company_id])
      @job = Job.find(params[:id])
    end
  end

  def update
    edit
    @company = params[:company_id]
    @job.company_id = @company
    @job.update(job_params)
      if @job.update(job_params)
        flash[:notice] = "Job details successfully updated."
        redirect_to company_job_path(@company, @job)
      else
        render :edit
      end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path
  end

  private

  def registered_job
    @job = Job.new(job_params)
    @company =  params[:company_id]
    @job.company_id = @company
      if params[:previewButt] == "Preview"
        flash[:alert] = "This is a PREVIEW of your job posting. Go back to the previous tab to Post the job or make edits."
        render :create
      elsif params[:createButt] == "Post Job"
        @job.save
        flash[:notice] = "Success!"
        redirect_to company_job_path(@company, @job)
      else
        render :new
      end
  end

  def quick_job
    @job = Job.new(job_params)
      if params[:previewButt] == "Preview"
        # flash[:alert] = "This is a PREVIEW of your job posting. Go back to the previous tab to Post the job or make edits."
        render :create
      elsif
        params[:createButt] == "Post Job"
        @job.save
        flash[:notice] = "Success!"
        redirect_to @job
      else
        render :new
      end
  end


  def job_params
    params.require(:job).permit(:title, :description, :role, :job_type, :location, :keywords,
      :company_id, :salary, :pitch, :unregistered_company_name, :unregistered_company_logo,
      :unregistered_company_photo, :job_application_type, :job_email, :job_url, perk_ids:[])
  end
end
