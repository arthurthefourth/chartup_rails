class Chart < ActiveRecord::Base
  require 'open3'
  require Rails.root + "chartup/lib/chartup.rb"
  #attr_accessor :title, :chartup, :composer

  belongs_to :user
  after_validation :sync_titles

  validates :title, presence: true
  validates :chartup, presence: true
  validate :chartup_must_be_valid 

  # Converts Chartup to Lilypond format, and generates the appropriate file
  def output_lilypond(format)
    filename = File.join(Rails.root, 'downloads', SecureRandom.uuid)
    lilypond_path = Rails.application.config.lilypond_path
    chartup = Chartup::Chart.new(self.chartup)
    case format
    when :pdf
      Open3.capture2("#{lilypond_path} --output=#{filename} -", :stdin_data => chartup.to_ly)
    when :png
      Open3.capture2("#{lilypond_path}  --output=#{filename} -dbackend=eps -dno-gs-load-fonts -dinclude-eps-fonts -ddelete-intermediate-files --png -", :stdin_data => chartup.to_ly)
    end
    "#{filename}.#{format.to_s}"
  rescue Chartup::Error
    raise
  end


  def chartup_without_title
    if self.chartup
      self.chartup.lines.reject {|line| is_title(line)}.map! {|line| line.chomp }.compact.join("\n")
    else
      ''
    end
  end

  def same_chart(other_chart)
    (self.chartup == other_chart.chartup) && (self.title == other_chart.title)
  end

  # Nicely formatted time/date last updated
  def last_updated
    time = self.updated_at
    if time < Time.now - (3600 * 24)
      time.strftime("%b %-d, %Y")
    else
      time.strftime("%l:%M %p")
    end
  end

  private

  # Chart objects have a title field, but Chartup documents also store titles.
  # This method makes sure the titles are in sync before saving.
  # Submitted title field overrides title in Chartup document
  def sync_titles
    # Title was submitted
    if self.title.blank?
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

  def chartup_must_be_valid
    Chartup.validate_syntax(chartup)
  rescue Chartup::Error => error
    errors.add(:chartup, "error: #{error.to_s}")
  end
end
