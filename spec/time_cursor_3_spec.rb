require 'spec_helper'

describe "TimeCursor::Matcher#forward_to_year" do
  matcher = TimeCursor.at( Time.now )
  [
    [ 2014,     "2015-02-26 01:23:45",  nil                   ],
    [ 2015,     "2015-02-26 01:23:45",  nil                   ],
    [ 2016,     "2015-02-26 01:23:45",  "2016-01-01 00:00:00" ],
  ].each do |year, base, expected|
    it "" do
      expect( matcher.forward_to_year( Time.parse( base ), year ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#forward_to_month" do
  matcher = TimeCursor.at( Time.now )
  [
    [    1,     "2015-02-26 01:23:45",  "2016-01-01 00:00:00" ],
    [    2,     "2015-02-26 01:23:45",  "2016-02-01 00:00:00" ],
    [    3,     "2015-02-26 01:23:45",  "2015-03-01 00:00:00" ],
    [    4,     "2015-02-26 01:23:45",  "2015-04-01 00:00:00" ],
  ].each do |month, base, expected|
    it "" do
      expect( matcher.forward_to_month( Time.parse( base ), month ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#forward_to_day" do
  matcher = TimeCursor.at( Time.now )
  [
    [   25,     "2015-02-26 01:23:45",  "2015-03-25 00:00:00" ],
    [   26,     "2015-02-26 01:23:45",  "2015-03-26 00:00:00" ],
    [   27,     "2015-02-26 01:23:45",  "2015-02-27 00:00:00" ],
    [   28,     "2015-02-26 01:23:45",  "2015-02-28 00:00:00" ],
    [   29,     "2015-02-26 01:23:45",  "2015-03-29 00:00:00" ],
    [   30,     "2015-02-26 01:23:45",  "2015-03-30 00:00:00" ],
    [   31,     "2015-02-26 01:23:45",  "2015-03-31 00:00:00" ],
    [    1,     "2015-02-26 01:23:45",  "2015-03-01 00:00:00" ],
    [    2,     "2015-02-26 01:23:45",  "2015-03-02 00:00:00" ],
  ].each do |day, base, expected|
    it "" do
      expect( matcher.forward_to_day( Time.parse( base ), day ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#forward_to_wday" do
  matcher = TimeCursor.at( Time.now )
  [
    [    0,     "2015-02-26 01:23:45",  "2015-03-01 00:00:00" ],
    [    1,     "2015-02-26 01:23:45",  "2015-03-02 00:00:00" ],
    [    2,     "2015-02-26 01:23:45",  "2015-03-03 00:00:00" ],
    [    3,     "2015-02-26 01:23:45",  "2015-03-04 00:00:00" ],
    [    4,     "2015-02-26 01:23:45",  "2015-03-05 00:00:00" ],
    [    5,     "2015-02-26 01:23:45",  "2015-02-27 00:00:00" ],
    [    6,     "2015-02-26 01:23:45",  "2015-02-28 00:00:00" ],
  ].each do |wday, base, expected|
    it "" do
      expect( matcher.forward_to_wday( Time.parse( base ), wday ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#forward_to_hour" do
  matcher = TimeCursor.at( Time.now )
  [
    [    0,     "2015-02-26 01:23:45",  "2015-02-27 00:00:00" ],
    [    1,     "2015-02-26 01:23:45",  "2015-02-27 01:00:00" ],
    [    2,     "2015-02-26 01:23:45",  "2015-02-26 02:00:00" ],
    [    3,     "2015-02-26 01:23:45",  "2015-02-26 03:00:00" ],
  ].each do |hour, base, expected|
    it "" do
      expect( matcher.forward_to_hour( Time.parse( base ), hour ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#forward_to_min" do
  matcher = TimeCursor.at( Time.now )
  [
    [    0,     "2015-02-26 01:23:45",  "2015-02-26 02:00:00" ],
    [   10,     "2015-02-26 01:23:45",  "2015-02-26 02:10:00" ],
    [   20,     "2015-02-26 01:23:45",  "2015-02-26 02:20:00" ],
    [   30,     "2015-02-26 01:23:45",  "2015-02-26 01:30:00" ],
    [   40,     "2015-02-26 01:23:45",  "2015-02-26 01:40:00" ],
    [   50,     "2015-02-26 01:23:45",  "2015-02-26 01:50:00" ],
  ].each do |min, base, expected|
    it "" do
      expect( matcher.forward_to_min( Time.parse( base ), min ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#forward_to_sec" do
  matcher = TimeCursor.at( Time.now )
  [
    [    0,     "2015-02-26 01:23:45",  "2015-02-26 01:24:00" ],
    [   10,     "2015-02-26 01:23:45",  "2015-02-26 01:24:10" ],
    [   20,     "2015-02-26 01:23:45",  "2015-02-26 01:24:20" ],
    [   30,     "2015-02-26 01:23:45",  "2015-02-26 01:24:30" ],
    [   40,     "2015-02-26 01:23:45",  "2015-02-26 01:24:40" ],
    [   50,     "2015-02-26 01:23:45",  "2015-02-26 01:23:50" ],
  ].each do |sec, base, expected|
    it "" do
      expect( matcher.forward_to_sec( Time.parse( base ), sec ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#forward_to_usec" do
  matcher = TimeCursor.at( Time.now )
  [
    [    0,     "2015-02-26 01:23:45.678",  "2015-02-26 01:23:46.000" ],
    [  200,     "2015-02-26 01:23:45.678",  "2015-02-26 01:23:46.200" ],
    [  400,     "2015-02-26 01:23:45.678",  "2015-02-26 01:23:46.400" ],
    [  600,     "2015-02-26 01:23:45.678",  "2015-02-26 01:23:46.600" ],
    [  800,     "2015-02-26 01:23:45.678",  "2015-02-26 01:23:45.800" ],
  ].each do |msec, base, expected|
    it "" do
      expect( matcher.forward_to_usec( Time.parse( base ), msec * 1000 ) ).to  eq( ( Time.parse( expected ) ) )
    end
  end
end


describe "TimeCursor::Matcher#back_to_year" do
  matcher = TimeCursor.at( Time.now )
  [
    [ 2014,     "2015-02-26 01:23:45",  "2014-12-31 23:59:59" ],
    [ 2015,     "2015-02-26 01:23:45",  nil                   ],
    [ 2016,     "2015-02-26 01:23:45",  nil                   ],
  ].each do |year, base, expected|
    it "" do
      expect( matcher.back_to_year( Time.parse( base ), year ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#back_to_month" do
  matcher = TimeCursor.at( Time.now )
  [
    [    1,     "2015-02-26 01:23:45",  "2015-01-31 23:59:59" ],
    [    2,     "2015-02-26 01:23:45",  "2014-02-28 23:59:59" ],
    [    3,     "2015-02-26 01:23:45",  "2014-03-31 23:59:59" ],
    [    4,     "2015-02-26 01:23:45",  "2014-04-30 23:59:59" ],
  ].each do |month, base, expected|
    it "" do
      expect( matcher.back_to_month( Time.parse( base ), month ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#back_to_day" do
  matcher = TimeCursor.at( Time.now )
  [
    [   25,     "2015-02-26 01:23:45",  "2015-02-25 23:59:59" ],
    [   26,     "2015-02-26 01:23:45",  "2015-01-26 23:59:59" ],
    [   27,     "2015-02-26 01:23:45",  "2015-01-27 23:59:59" ],
    [   28,     "2015-02-26 01:23:45",  "2015-01-28 23:59:59" ],
    [   29,     "2015-02-26 01:23:45",  "2015-01-29 23:59:59" ],
    [   30,     "2015-02-26 01:23:45",  "2015-01-30 23:59:59" ],
    [   31,     "2015-02-26 01:23:45",  "2015-01-31 23:59:59" ],
    [    1,     "2015-02-26 01:23:45",  "2015-02-01 23:59:59" ],
    [    2,     "2015-02-26 01:23:45",  "2015-02-02 23:59:59" ],
  ].each do |day, base, expected|
    it "" do
      expect( matcher.back_to_day( Time.parse( base ), day ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#back_to_wday" do
  matcher = TimeCursor.at( Time.now )
  [
    [    0,     "2015-02-26 01:23:45",  "2015-02-22 23:59:59" ],
    [    1,     "2015-02-26 01:23:45",  "2015-02-23 23:59:59" ],
    [    2,     "2015-02-26 01:23:45",  "2015-02-24 23:59:59" ],
    [    3,     "2015-02-26 01:23:45",  "2015-02-25 23:59:59" ],
    [    4,     "2015-02-26 01:23:45",  "2015-02-19 23:59:59" ],
    [    5,     "2015-02-26 01:23:45",  "2015-02-20 23:59:59" ],
    [    6,     "2015-02-26 01:23:45",  "2015-02-21 23:59:59" ],
  ].each do |wday, base, expected|
    it "" do
      expect( matcher.back_to_wday( Time.parse( base ), wday ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#back_to_hour" do
  matcher = TimeCursor.at( Time.now )
  [
    [    0,     "2015-02-26 01:23:45",  "2015-02-26 00:59:59" ],
    [    1,     "2015-02-26 01:23:45",  "2015-02-25 01:59:59" ],
    [    2,     "2015-02-26 01:23:45",  "2015-02-25 02:59:59" ],
    [    3,     "2015-02-26 01:23:45",  "2015-02-25 03:59:59" ],
  ].each do |hour, base, expected|
    it "" do
      expect( matcher.back_to_hour( Time.parse( base ), hour ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#back_to_min" do
  matcher = TimeCursor.at( Time.now )
  [
    [    0,     "2015-02-26 01:23:45",  "2015-02-26 01:00:59" ],
    [   10,     "2015-02-26 01:23:45",  "2015-02-26 01:10:59" ],
    [   20,     "2015-02-26 01:23:45",  "2015-02-26 01:20:59" ],
    [   30,     "2015-02-26 01:23:45",  "2015-02-26 00:30:59" ],
    [   40,     "2015-02-26 01:23:45",  "2015-02-26 00:40:59" ],
    [   50,     "2015-02-26 01:23:45",  "2015-02-26 00:50:59" ],
  ].each do |min, base, expected|
    it "" do
      expect( matcher.back_to_min( Time.parse( base ), min ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#back_to_sec" do
  matcher = TimeCursor.at( Time.now )
  [
    [    0,     "2015-02-26 01:23:45",  "2015-02-26 01:23:00" ],
    [   10,     "2015-02-26 01:23:45",  "2015-02-26 01:23:10" ],
    [   20,     "2015-02-26 01:23:45",  "2015-02-26 01:23:20" ],
    [   30,     "2015-02-26 01:23:45",  "2015-02-26 01:23:30" ],
    [   40,     "2015-02-26 01:23:45",  "2015-02-26 01:23:40" ],
    [   50,     "2015-02-26 01:23:45",  "2015-02-26 01:22:50" ],
  ].each do |sec, base, expected|
    it "" do
      expect( matcher.back_to_sec( Time.parse( base ), sec ) ).to  eq( ( Time.parse( expected ) rescue nil ) )
    end
  end
end

describe "TimeCursor::Matcher#back_to_usec" do
  matcher = TimeCursor.at( Time.now )
  [
    [    0,     "2015-02-26 01:23:45.678",  "2015-02-26 01:23:45.000" ],
    [  200,     "2015-02-26 01:23:45.678",  "2015-02-26 01:23:45.200" ],
    [  400,     "2015-02-26 01:23:45.678",  "2015-02-26 01:23:45.400" ],
    [  600,     "2015-02-26 01:23:45.678",  "2015-02-26 01:23:45.600" ],
    [  800,     "2015-02-26 01:23:45.678",  "2015-02-26 01:23:44.800" ],
  ].each do |msec, base, expected|
    it "" do
      expect( matcher.back_to_usec( Time.parse( base ), msec * 1000 ) ).to  eq( ( Time.parse( expected ) ) )
    end
  end
end

