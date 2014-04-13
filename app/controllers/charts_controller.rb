class ChartsController < ApplicationController
  def new
    @chart = Chart.new
    @chart.title = 'Untitled'
  end

  def create
    @chart = current_user.charts.new
    chartup = params[:chart][:chartup]
    @chart.title = title_from_chartup(chartup) || 'Untitled'
    @chart.chartup = chartup

    if @chart.save
      flash[:notice] = 'Chart created.'
      redirect_to edit_chart_path(@chart)
    else
      flash[:alert] = 'Something went wrong.'      
    end
  end

  def index
  end

  def edit
    @chart = Chart.find(params[:id])
    render 'new'
  end

  def update
    @chart = Chart.find(params[:id])
    chartup = params[:chart][:chartup]
    # Check for title
    # (This should probably be delegated to Chartdown parser)
    
    @chart.title = title_from_chartup(chartup) || @chart.title
    @chart.chartup = chartup

    if @chart.save
      flash[:notice] = 'Chart updated.'
      redirect_to edit_chart_path(@chart)
    else
      flash[:alert] = 'Something went wrong.'      
    end

  end

  def title_from_chartup(chartup)
    title = nil
    chartup.each_line do |line|
      if line.downcase.start_with? 'title:'
        title = line.split('title:')[1].strip
      end
    end
    title
  end
end
