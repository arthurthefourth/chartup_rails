require 'test_helper'

class ChartTest < ActiveSupport::TestCase

  test 'Basic chart should be valid' do
    c = charts(:basic)
    assert c.valid?
  end

  test 'Bad Chartup should not be valid' do
    c = Chart.create(title: 'Title', chartup: 'H7')
    assert !c.valid?
  end

  test 'Chart title should be saved to Chartup document' do
    c = charts(:basic)
    c.save
    assert_match "title: Title", c.chartup
  end

  test 'Chart title should take precedence over Chartup title' do
    c = Chart.create(title: 'Title1', chartup: "title: title2\nAm")
    c.save
    assert_match "title: Title1", c.chartup
    assert_no_match "title: Title2", c.chartup
  end

  test 'output_lilypond creates a pdf' do
    c = charts(:basic)
    path = c.output_lilypond(:pdf)
    assert_match '.pdf', path
  end

  test 'output_lilypond creates a png' do
    c = charts(:basic)
    path = c.output_lilypond(:png)
    assert_match '.png', path
  end

  test 'last_updated returns nicely formatted date' do
  end

end