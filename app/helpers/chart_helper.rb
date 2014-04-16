require 'open3'
module ChartHelper
  def output_lilypond(chartup, format)
    filename = File.join(Rails.root,'lilypond_renders', SecureRandom.uuid)
    lilypond = '/usr/local/bin/lilypond'
    case format
    when :pdf
      Open3.capture2("#{lilypond} --output=#{filename} -", :stdin_data => chartup.to_ly)
    when :png
      Open3.capture2("#{lilypond}  --output=#{filename} -dbackend=eps -dno-gs-load-fonts -dinclude-eps-fonts --png -", :stdin_data => chartup.to_ly)
    end
    filename
  end

end
