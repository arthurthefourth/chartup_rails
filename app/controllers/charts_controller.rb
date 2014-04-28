class ChartsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update, :create]


  def index
  end

  # Default interface for editing chart from browser storage
  def home
    @chart = Chart.new
    render :new
  end

  def new
    @chart = Chart.new
    @chart.title = 'Untitled'
  end

  def edit
    @chart = current_user.charts.find(params[:id])
  end

  def show
    edit
  end

  def destroy
    Chart.find(params[:id]).destroy
    flash[:notice] = 'Chart deleted.'
    redirect_to charts_path
  end

  def create
    @chart = current_user.charts.build(chart_params)
    if @chart.save
      flash[:notice] = 'Chart saved.'
      redirect_to edit_chart_path(@chart)
    else
      flash[:alert] = "Something went wrong. #{@chart.errors}"  
      render :edit    
    end
  end

  def update
    @chart = current_user.charts.find(params[:id])
    if @chart.update_attributes(chart_params)
      flash[:notice] = 'Chart updated.'
      redirect_to edit_chart_path(@chart)
    else
      flash[:alert] = 'Something went wrong. #{@chart.errors}' 
      render :edit
    end
  end

  # POSTing to preview returns the URL for the image
  def preview
    @chart = Chart.new(chart_params)
    if @chart.valid?
      png_url
    else
      render nothing: true
    end
  end

  # POSTing to download sends the actual PDF to the browser
  def download
    @chart = Chart.new(chart_params)
    if @chart.valid?
      send_pdf
    else
      render nothing: true
    end
  end

  def png_url
    png_file = @chart.output_lilypond(:png)
    render plain: File.join('/downloads', File.basename(png_file))
  end

  def send_pdf
    pdf_file = @chart.output_lilypond(:pdf)
    pdf_name = "#{@chart.title}.pdf"
    send_file pdf_file, filename: pdf_name, type: 'application/pdf'
  end

  # GETting "downloads/:filename" sends a PNG file
  def send_png
    png_name = "#{params[:filename]}.#{params[:format]}"
    path = File.join(Rails.root, 'downloads', png_name)
    send_file path, type: 'image/png'
  end

  private
  def chart_params
    params.require(:chart).permit(:title, :chartup)
  end


end
