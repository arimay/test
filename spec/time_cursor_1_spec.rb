require 'spec_helper'

describe "TimeCursor::Elements.build" do
  [
    ["*",                               nil,    []                       ],
    ["*/10",                            0..59,  [0, 10, 20, 30, 40, 50]  ],
    ["10",                              0..59,  [10]                     ],
    ["10,30",                           0..59,  [10, 30]                 ],
    ["10-15",                           0..59,  [10, 11, 12, 13, 14, 15] ],
    ["10-40/10",                        0..59,  [10, 20, 30, 40]         ],
    ["*/200",                           0..999, [0, 200, 400, 600, 800]  ],

    ["5-55/10",                         0..59,  [5, 15, 25, 35, 45, 55]  ],
    ["22-5",                            0..23,  [0, 1, 2, 3, 4, 5,22,23] ],

    ["sun,mon,tue,wed,thr,fri,sat",     0..6,   [0, 1, 2, 3, 4, 5, 6]    ],
    ["mon-fri",                         0..6,   [1, 2, 3, 4, 5]          ],
    ["sat-sun",                         0..6,   [0, 6]                   ],

    ["jan,feb,mar,apr,may,jun",         1..12,  [1, 2, 3, 4, 5, 6]       ],
    ["jul,aug,sep,oct,nov,dec",         1..12,  [7, 8, 9,10,11,12]       ],
    ["jan-mar,oct-dec",                 1..12,  [1, 2, 3,10,11,12]       ],
    ["dec-jan",                         1..12,  [1,12]                   ],

    [nil,                               nil,    []                       ],
    [2..4,                              0..6,   [2, 3, 4]                ],
    [[3,4,5],                           0..6,   [3, 4, 5]                ],
    [456,                               nil,    [456]                    ],
    [:sun,                              0..6,   [0]                      ],
    [[:jan, :feb, :mar],                1..12,  [1, 2, 3]                ],
  ].each do |target, range, expected|
    it "" do
      expect( TimeCursor::Elements.build( target, range ) ).to  eq( expected )
    end
  end
end

describe "TimeCursor::Elements#right" do
  [
    [ [ 1, 3 ],         0,      1 ],
    [ [ 1, 3 ],         1,      3 ],
    [ [ 1, 3 ],         2,      3 ],
    [ [ 1, 3 ],         3,    nil ],
    [ [ 1, 3 ],         4,    nil ],
  ].each do |array, item, expected|
    it "" do
      expect( TimeCursor::Elements.new( array ).right( item ) ).to  eq( expected )
    end
  end
end

describe "TimeCursor::Elements#left" do
  [
    [ [ 1, 3 ],         0,    nil ],
    [ [ 1, 3 ],         1,    nil ],
    [ [ 1, 3 ],         2,      1 ],
    [ [ 1, 3 ],         3,      1 ],
    [ [ 1, 3 ],         4,      3 ],
  ].each do |array, item, expected|
    it "" do
      expect( TimeCursor::Elements.new( array ).left( item ) ).to  eq( expected )
    end
  end
end

describe "TimeCursor::Elements#correspond?" do
  [
    [ [      ],         0,   true ],
    [ [ 1, 3 ],         0,  false ],
    [ [ 1, 3 ],         1,   true ],
    [ [ 1, 3 ],         2,  false ],
    [ [ 1, 3 ],         3,   true ],
    [ [ 1, 3 ],         4,  false ],
  ].each do |array, item, expected|
    it "" do
      expect( TimeCursor::Elements.new( array ).correspond?( item ) ).to  eq( expected )
    end
  end
end

