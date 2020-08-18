
module TimeCursor

  class Elements < Array

    DATE_ALIAS  =  {
      'sun'=>'0', 'mon'=>'1', 'tue'=>'2', 'wed'=>'3',  'thr'=>'4',  'fri'=>'5', 'sat'=>'6',
      'jan'=>'1', 'feb'=>'2', 'mar'=>'3', 'apr'=>'4',  'may'=>'5',  'jun'=>'6',
      'jul'=>'7', 'aug'=>'8', 'sep'=>'9', 'oct'=>'10', 'nov'=>'11', 'dec'=>'12',
    }
    RE_ALL   =  %r|\A\*(/1)?\Z|
    RE_WILD  =  %r|\A\*(/(\d+))?\Z|
    RE_LIST  =  %r|\A(\d+)(-(\d+)(/(\d+))?)?\Z|

    def self.build( target, range = nil )
      case  target
      when  Array
        target  =  target.join(',')

      when  Symbol
        target  =  target.to_s

      end

      case  target
      when  NilClass
        Elements.new( [] )

      when  Range
        Elements.new( target.to_a )

      when  Numeric
        Elements.new( [target] )

      when  String
        factors  =  DATE_ALIAS.inject( target.downcase ) do |s, (k, v)| s.gsub( k, v ) end
        items  =  factors.split(',').map do |factor|
          if  m = RE_ALL.match( factor )
            []
          elsif  m = RE_WILD.match( factor )
            if  range.nil?
              raise  ArgumentError, "disallow wildcard without range : '#{target}'"
            end
            from  =  range.first
            to    =  range.last
            step  =  ( m[2] || 1 ).to_i
            expand( from, to, step, range )
          elsif  m = RE_LIST.match( factor )
            from  =  ( m[1] ).to_i
            to    =  ( m[3] || m[1] ).to_i
            step  =  ( m[5] || 1 ).to_i
            expand( from, to, step, range )
          else
            raise  ArgumentError, "format invalid : '#{target}'"
          end
        end
        Elements.new( items.flatten.sort.uniq )

      else
        raise  ArgumentError, "type invalid : '#{target}'"

      end
    end

    def self.expand( from, to, step, range )
      result  =  []
      cur  =  from
      if  from <= to
        loop do
          result  <<  cur
          cur  +=  step
          break    if  cur > to
        end
      else
        loop do
          result  <<  cur
          cur  +=  step
          break    if  cur > range.last
        end
        cur  =  range.first
        loop do
          result  <<  cur
          cur  +=  step
          break    if  cur > to
        end
      end
      result
    end

    def right( item )
      0.upto(self.size-1) do |i|
        return  self[i]    if  item < self[i]
      end
      nil
    end

    def left( item )
      (self.size-1).downto(0) do |i|
        return  self[i]    if  self[i] < item
      end
      nil
    end

    def correspond?( item )
      self.empty?  ||  self.include?( item )
    end

  end

end

