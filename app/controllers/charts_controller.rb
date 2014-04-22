class ChartsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :update, :edit, :create]


  def index
  end

  def show
    edit
  end

  def edit
    @chart = Chart.find(params[:id])
    render :edit
  end

  def new
    @chart = Chart.new
    @chart.title = 'Untitled'
    render :edit
  end


  def create
    @chart = current_user.charts.build(chart_params)
    if @chart.save
      flash[:notice] = 'Chart created.'
      render :edit
    else
      flash[:alert] = "Something went wrong. #{@chart.errors}"  
      render :edit    
    end
  end


  def update
    @chart = current_user.charts.find(params[:id])
    if @chart.update_attributes(chart_params)
      flash[:notice] = 'Chart updated.'
      render :edit
    else
      flash[:alert] = 'Something went wrong.' 
      render :edit
    end
  end

  def preview
    @chart = Chart.new(chart_params)
    if @chart.valid?
      png
    else
      render nothing: true
    end
  end

  def download
    @chart = Chart.new(chart_params)
    if @chart.valid?
      pdf
    else
      render nothing: true
    end
  end

  def pdf
    pdf_file = @chart.output_lilypond(:pdf)
    pdf_name = "#{@chart.title}.pdf"
    send_file pdf_file, filename: pdf_name, type: 'application/pdf'
  end

  def png
    png_file = @chart.output_lilypond(:png)
    render plain: File.join('/downloads', File.basename(png_file))
  end

  def embed_png
    filename = "#{params[:filename]}.#{params[:format]}"
    path = File.join(Rails.root, 'downloads', filename)
    send_file path, type: 'image/png'
    logger.debug "Sending png file: #{path}"
  end

  private
  def chart_params
    params.require(:chart).permit(:title, :chartup)
  end

end
