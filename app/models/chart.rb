class Chart < ActiveRecord::Base
  # attr_accessor :title, :chartup
  belongs_to :user
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

end
