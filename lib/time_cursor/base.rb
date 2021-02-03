require "time"
require "date"

module TimeCursor

  module Base

    def new( at: nil, cron: nil, year: nil, month: nil, day: nil, wday: nil, hour: nil, min: nil, sec: 0, msec: nil )
      if  !at.nil?
        at( at )
      elsif  !cron.nil?
        cron( cron )
      else
        detail( year: year, month: month, day: day, wday: wday, hour: hour, min: min, sec: sec, msec: msec )
      end
    end

    def at( time )
      case  time
      when  String
        date  =  Date.parse( time )  rescue  nil
        time  =  Time.parse( time )
      when  Time
        date  =  time.to_date
      end

      case  time
      when  Date
        Matcher.new(
          year:   time.year,
          month:  time.month,
          day:    time.day,
          hour:   0,
          min:    0,
          sec:    0,
        )
      when  Time
        if  date.nil?
          Matcher.new(
            hour:   time.hour,
            min:    time.min,
            sec:    time.sec,
          )
        else
          Matcher.new(
            year:   time.year,
            month:  time.month,
            day:    time.day,
            hour:   time.hour,
            min:    time.min,
            sec:    time.sec,
          )
        end
      else
        raise  ArgumentError, "invalid class : '#{datetime}'"
      end
    end

    def cron( patterns )
      unless  patterns.is_a? String
        raise  ArgumentError, "invalid class : '#{patterns}'"
      end
      a  =  patterns.split("\s")
      unless  a.size == 5
        raise  ArgumentError, "too/few count of fields : '#{patterns}'"
      end
      Matcher.new(
        month:  a[3],
        day:    a[2],
        wday:   a[4],
        hour:   a[1],
        min:    a[0],
      )
    end

    def detail( year: nil, month: nil, day: nil, wday: nil, hour: nil, min: nil, sec: 0, msec: nil )
      if  msec.nil?
        month  ||=  1    unless  year.nil?
        day    ||=  1    unless  month.nil?
        hour   ||=  0    unless  ( day.nil? && wday.nil? )
        min    ||=  0    unless  hour.nil?
        Matcher.new(
          year:   year,
          month:  month,
          day:    day,
          wday:   wday,
          hour:   hour,
          min:    min,
          sec:    sec,
        )
      else
        Matcher.new(
          msec:   msec,
        )
      end
    end

  end

end

