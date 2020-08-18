require "time"
require "date"

module TimeCursor

  class Matcher

    def initialize( year: '*', month: '*', day: '*', wday: '*', hour: '*', min: '*', sec: 0, msec: nil )
      if  msec.nil?
        @years    =  Elements.build( year           )
        @months   =  Elements.build( month,  1..12  )
        @days     =  Elements.build( day,    1..31  )
        @wdays    =  Elements.build( wday,   0..6   )
        @hours    =  Elements.build( hour,   0..23  )
        @mins     =  Elements.build( min,    0..59  )
        @secs     =  Elements.build( sec,    0..59  )
        @usecs    =  Elements.new

        if  !@years.empty? || !@months.empty? || !@days.empty? || !@wdays.empty?
          @next_for  =  :next_for_date
          @prev_for  =  :prev_for_date

        elsif  !@hours.empty? || !@mins.empty?
          @next_for  =  :next_for_time
          @prev_for  =  :prev_for_time

        else
          @secs  =  Elements.build( '0-59', 0..59 )    if @secs.empty?
          @next_for  =  :next_for_sec
          @prev_for  =  :prev_for_sec

        end

      else
        @years    =  Elements.new
        @months   =  Elements.new
        @days     =  Elements.new
        @wdays    =  Elements.new
        @hours    =  Elements.new
        @mins     =  Elements.new
        @secs     =  Elements.new
        @usecs    =  Elements.build( msec,   0..999 )
        @usecs.each_with_index do |item, ndx|
          @usecs[ndx]  *= 1000
        end

        @next_for  =  :next_for_usec
        @prev_for  =  :prev_for_usec

      end
    end

    def next( time = Time.now )
      case  time
      when  Time
      when  String
        time  =  Time.parse( time )
      else
        raise  ArgumentError, "can not parse as time."
      end
      send( @next_for, time )
    end

    def prev( time = Time.now )
      case  time
      when  Time
      when  String
        time  =  Time.parse( time )
      else
        raise  ArgumentError, "can not parse as time."
      end
      send( @prev_for, time )
    end

    def match( time = Time.now )
      case  time
      when  Time
      when  String
        time  =  Time.parse( time )
      else
        raise  ArgumentError, "can not parse as time."
      end

      if  @years.correspond?( time.year )  &&
          @months.correspond?( time.month )  &&
          @days.correspond?( time.day )  &&
          @hours.correspond?( time.hour )  &&
          @mins.correspond?( time.min )  &&
          @secs.correspond?( time.sec )
        time
      else
        nil
      end
    end

    # private

    def next_for_date( time )
      time  +=  1
      loop do
        if  !@years.correspond?( year = time.year )
          year  =  @years.right( year )
          return  time  =  nil   if  year.nil?
          time  =  forward_to_year( time, year )

        elsif  !@months.correspond?( month = time.month )
          month  =  @months.right( month ) || @months.first
          time  =  forward_to_month( time, month )

        elsif  !@wdays.correspond?( wday = time.wday )
          wday  =  @wdays.right( wday ) || @wdays.first
          time  =  forward_to_wday( time, wday )

        elsif  !@days.correspond?( day = time.day )
          day  =  @days.right( day ) || @days.first
          time  =  forward_to_day( time, day )

        elsif  !@hours.correspond?( hour = time.hour )
          hour  =  @hours.right( hour ) || @hours.first
          time  =  forward_to_hour( time, hour )

        elsif  !@mins.correspond?( min = time.min )
          min  =  @mins.right( min ) || @mins.first
          time  =  forward_to_min( time, min )

        elsif  !@secs.correspond?( sec = time.sec )
          sec  =  @secs.right( sec ) || @secs.first
          time  =  forward_to_sec( time, sec )

        else
          return  time

        end
      end
    end

    def next_for_time( time )
      time  +=  1
      loop do
        if  !@hours.correspond?( hour = time.hour )
          hour  =  @hours.right( hour ) || @hours.first
          time  =  forward_to_hour( time, hour )

        elsif  !@mins.correspond?( min = time.min )
          min  =  @mins.right( min ) || @mins.first
          time  =  forward_to_min( time, min )

        elsif  !@secs.correspond?( sec = time.sec )
          sec  =  @secs.right( sec ) || @secs.first
          time  =  forward_to_sec( time, sec )

        else
          return  time

        end
      end
    end

    def next_for_sec( time )
      sec  =  @secs.right( time.sec ) || @secs.first
      time  =  forward_to_sec( time, sec )
    end

    def next_for_usec( time )
      usec  =  @usecs.right( time.usec ) || @usecs.first
      time  =  forward_to_usec( time, usec )
    end

    def prev_for_date( time )
      time  -=  1
      loop do
        if  !@years.correspond?( year = time.year )
          year  =  @years.left( year )
          return  time  =  nil    if  year.nil?
          time  =  back_to_year( time, year )

        elsif  !@months.correspond?( month = time.month )
          month  =  @months.left( month ) || @months.last
          time  =  back_to_month( time, month )

        elsif  !@wdays.correspond?( wday = time.wday )
          wday  =  @wdays.left( wday ) || @wdays.last
          time  =  back_to_wday( time, wday )

        elsif  !@days.correspond?( day = time.day )
          day  =  @days.left( day ) || @days.last
          time  =  back_to_day( time, day )

        elsif  !@hours.correspond?( hour = time.hour )
          hour  =  @hours.left( hour ) || @hours.last
          time  =  back_to_hour( time, hour )

        elsif  !@mins.correspond?( min = time.min )
          min  =  @mins.left( min ) || @mins.last
          time  =  back_to_min( time, min )

        elsif  !@secs.correspond?( sec = time.sec )
          sec  =  @secs.left( sec ) || @secs.last
          time  =  back_to_sec( time, sec )

        else
          return  time

        end
      end
    end

    def prev_for_time( time )
      time  -=  1
      loop do
        if  !@hours.correspond?( hour = time.hour )
          hour  =  @hours.left( hour ) || @hours.last
          time  =  back_to_hour( time, hour )

        elsif  !@mins.correspond?( min = time.min )
          min  =  @mins.left( min ) || @mins.last
          time  =  back_to_min( time, min )

        elsif  !@secs.correspond?( sec = time.sec )
          sec  =  @secs.left( sec ) || @secs.last
          time  =  back_to_sec( time, sec )

        else
          return  time

        end
      end
    end

    def prev_for_sec( time )
      sec  =  @secs.left( time.sec ) || @secs.last
      time  =  back_to_sec( time, sec )
    end

    def prev_for_usec( time )
      usec  =  @usecs.left( time.usec ) || @usecs.last
      time  =  back_to_usec( time, usec )
    end

    def forward_to_year( time, year )
      if time.year < year
        Time.new( year )
      else
        nil
      end
    end

    def forward_to_month( time, month )
      date  =  Date.new( time.year, time.month, time.day )
      loop do
        date  =  date.next_month
        break    if  date.month == month
      end
      Time.new( date.year, date.month )
    end

    def forward_to_day( time, day )
      date  =  Date.new( time.year, time.month, time.day )
      loop do
        date  =  date.next_day
        break    if  date.day == day
      end
      Time.new( date.year, date.month, date.day )
    end

    def forward_to_wday( time, wday )
      date  =  Date.new( time.year, time.month, time.day )
      loop do
        date  =  date.next_day
        break    if  date.wday == wday
      end
      Time.new( date.year, date.month, date.day )
    end

    def forward_to_hour( time, hour )
      time  +=  60 * 60 * 24    if hour <= time.hour
      Time.new( time.year, time.month, time.day, hour )
    end

    def forward_to_min( time, min )
      time  +=  60 * 60    if min <= time.min
      Time.new( time.year, time.month, time.day, time.hour, min )
    end

    def forward_to_sec( time, sec )
      time  +=  60    if sec <= time.sec
      Time.new( time.year, time.month, time.day, time.hour, time.min, sec )
    end

    def forward_to_usec( time, usec )
      time  +=  1    if  usec <= time.usec
      Time.local( time.year, time.month, time.day, time.hour, time.min, time.sec, usec )
    end

    def back_to_year( time, year )
      if year < time.year
        Time.new( year + 1 ) - 1
      else
        nil
      end
    end

    def back_to_month( time, month )
      date  =  Date.new( time.year, time.month, time.day )
      loop do
        date  =  date.prev_month
        break    if  date.month == month
      end
      date  =  date.next_month
      Time.new( date.year, date.month ) - 1
    end

    def back_to_day( time, day )
      date  =  Date.new( time.year, time.month, time.day )
      loop do
        date  =  date.prev_day
        break    if  date.day == day
      end
      date  =  date.next_day
      Time.new( date.year, date.month, date.day ) - 1
    end

    def back_to_wday( time, wday )
      date  =  Date.new( time.year, time.month, time.day )
      loop do
        date  =  date.prev_day
        break    if  date.wday == wday
      end
      date  =  date.next_day
      Time.new( date.year, date.month, date.day ) - 1
    end

    def back_to_hour( time, hour )
      time  -=  60 * 60 * 24    if  time.hour <= hour
      Time.new( time.year, time.month, time.day, hour, 59, 59 )
    end

    def back_to_min( time, min )
      time  -=  60 * 60    if  time.min <= min
      Time.new( time.year, time.month, time.day, time.hour, min, 59 )
    end

    def back_to_sec( time, sec )
      time  -=  60    if  time.sec <= sec
      Time.new( time.year, time.month, time.day, time.hour, time.min, sec )
    end

    def back_to_usec( time, usec )
      time  -=  1    if  time.usec < usec
      Time.local( time.year, time.month, time.day, time.hour, time.min, time.sec, usec )
    end

  end

end

