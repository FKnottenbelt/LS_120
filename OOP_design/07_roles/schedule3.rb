# adding more users of the ducktype

class Schedule
  def scheduled?(schedulable, start_date, end_date)
    puts "This #{schedulable.class} is not scheduled\n" +
         "between #{start_date} and #{end_date}"
    false
  end
end

module Schedulabe
  attr_writer :schedule

  def schedule
    @schedule ||= ::Schedule.new
  end

  # return true if this object is available during this interval
  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end

  # return the schedule's answer
  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end

  # includers may override
  def lead_days # hook
    0
  end
end

class Bicycle
  include Schedulabe

  attr_reader :size, :chain, :tire_size, :schedule

  def initialize(args={}) # inject schedule and provide default
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    @schedule = args[:schedule] || Schedule.new

    post_initialize(args)
  end

  # return the number of lead_days before a bicyle can be scheduled
  def lead_days
    1
  end

  def spares
    { tire_size: tire_size,
      chain: chain }.merge(local_spares) # calling hook
  end

  def default_tire_size
  #  raise MethodNotImplemented,
   # "This #{self.class} cannot respond to default_tire_size"
   '23'
  end

  # subclasses may override this hook messages:
  def post_initialize(args)
    nil
  end

  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end
end

class Vehicle
  include Schedulabe

  def lead_days
    3
  end
end

class Mechanic
  include Schedulabe

  def lead_days
    4
  end
end


require 'date'
starting = Date.parse("2015/09/04")
ending = Date.parse("2015/09/10")

b = Bicycle.new
b.schedulable?(starting, ending)

v = Vehicle.new
v.schedulable?(starting, ending)

m = Mechanic.new
m.schedulable?(starting, ending)

# This Bicycle is not scheduled
# between 2015-09-03 and 2015-09-10
# This Vehicle is not scheduled
# between 2015-09-01 and 2015-09-10
# This Mechanic is not scheduled
# between 2015-08-31 and 2015-09-10