class Chart < ActiveRecord::Base
  require 'open3'
  #attr_accessor :title, :chartup, :composer

  belongs_to :user
  after_validation :set_titles

  validates :title, presence: true
  validates :chartup, presence: true

  def output_lilypond(format)
    filename = File.join(Rails.root, 'downloads', SecureRandom.uuid)
    lilypond_path = Rails.application.config.lilypond_path
    chartup = Chartup::Chart.new(self.chartup)
    case format
    when :pdf
      Open3.capture2("#{lilypond_path} --output=#{filename} -", :stdin_data => chartup.to_ly)
    when :png
      Open3.capture2("#{lilypond_path}  --output=#{filename} -dbackend=eps -dno-gs-load-fonts -dinclude-eps-fonts --png -", :stdin_data => chartup.to_ly)
    end
    "#{filename}.#{format.to_s}"
  end

  def chartup_without_title
    if chartup
      chartup.lines.reject {|line| is_title(line)}.map! {|line| line.chomp }.compact.join("\n")
    else
      ''
    end
  end

  private
  # Submitted title field overrides title in Chartup document
  def set_titles
    # Title was submitted
    if self.title.empty?
      self.title = get_title_from_chartup(chartup) || 'Untitled'
    else
      set_chartup_title(self.title)
    end
  end

  def get_title_from_chartup(chartup)
    chartup.each_line do |line|
      if is_title(line)
        title_line = line.split('title:')[1].strip
        return title_line
      end
    end
    return nil
  end

  def set_chartup_title(new_title)
    self.chartup = ["title: #{new_title}", chartup_without_title].join("\n")
  end


  def is_title(line)
    line.downcase.start_with? 'title:'
  end
end
