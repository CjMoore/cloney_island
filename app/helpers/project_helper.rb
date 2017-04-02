module ProjectHelper
  def format_date(date)
    end_date  = date.to_date
    now_date  = Time.now.to_date
    num_days  = (end_date - now_date).to_i
    hours     = date.hour
    now_hours = Time.now.hour
    num_hours = hours - now_hours
    if num_hours < 0
      num_days  = num_days - 1
      num_hours = 24 + num_hours
    end
    time_remaining = " #{num_days} days, #{num_hours} hours remaining to fund!"
    time_remaining
  end

  def percent_funded(total, funds)
    ((funds.to_f/total.to_f)*100).round(0)
  end
end
