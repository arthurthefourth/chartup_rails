class ChartsController < ApplicationController
  before_action :authenticate_user!

  def new
    @chart = Chart.new
    @chart.title = 'Untitled'
    render :edit
  end


  def create
    @chart = current_user.charts.build(chart_params)
    case params[:commit]
    when 'Save'
      save_created
    when 'Download PDF'
      pdf
    when 'Preview'
      png
    end
  end

  def save_created
    if @chart.save
      flash[:notice] = 'Chart created.'
      render :edit
    else
      #flash[:alert] = "Something went wrong. #{@chart.errors}"  
      render :edit    
    end
  end

  def index
  end

  def show
    edit
  end

  def edit
    @chart = Chart.find(params[:id])
    render :edit
  end

  def update
    case params[:commit]
    when 'Save'
      save_updated
    when 'Download PDF'
      pdf
    when 'Preview'
      png
    end
  end

  def save_updated
    @chart = Chart.find(params[:id])
    if @chart.update_attributes(chart_params)
      flash[:notice] = 'Chart updated.'
      render :edit
    else
      #flash[:alert] = 'Something went wrong.' 
      render :edit
    end

  end

  def preview
    @chart = Chart.new(chart_params)
    if @chart.valid?
      png
    else
      render nothing: true
      #redirect_to :edit
    end
  end

  def pdf
    #@chart = Chart.find(params[:id])
    @chart = Chart.new(chart_params)
    if @chart.valid? #Titles are fixed up during validation; this is confusing
      pdf_path = @chart.output_lilypond(:pdf)
      pdf_name = "#{@chart.title}.pdf"
      send_file pdf_path, filename: pdf_name, type: 'application/pdf'
    end
  end

  def png
    #@chart = Chart.find(params[:id])
    png_path = @chart.output_lilypond(:png)
    render plain: File.join('/downloads', File.basename(png_path))
    #png_name = "#{@chart.title}.png"
    #send_file png_path, filename: png_name, type: 'image/png'
  end

  def download
    path = "#{params[:filename]}.#{params[:format]}"
    send_file File.join(Rails.root, 'downloads', path), type: 'image/png'
  end

  private
  def chart_params
    params.require(:chart).permit(:title, :chartup)
  end

end
