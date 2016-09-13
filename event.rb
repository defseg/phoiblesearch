#!/usr/bin/env ruby
require 'time' 
require 'set'
Event = Struct.new(:id, :start_time, :end_time) do
  # Ideally we'd have validation here to make sure start_time is before 
  # end_time, but that's not within the scope of the question.
  def to_s
    "{#{id}: #{start_time} - #{end_time}}"
  end 
end 
ConflictedTimeWindow = Struct.new(:start_time, :end_time, 
:conflicted_event_ids) do
  def to_s
    "{#{start_time} - #{end_time}: #{conflicted_event_ids}}"
  end
  def ==(obj)
    self.start_time == obj.start_time &&
      self.end_time == obj.end_time &&
      self.conflicted_event_ids.sort == obj.conflicted_event_ids.sort
  end 
end 
class Calendar
  def initialize
    @events = []
  end
  # Should allow multiple events to be scheduled over the same time 
  # window.
  def schedule(event)
    # IMPLEMENT ME
    @events << event
  end
  def find_conflicted_time_windows
    # to find overlapping events: a.end >= b.start && b.end >= a.start 
    # then how do we get the actual overlaps? min(a.end, b.end) - 
    # max(a.start, b.start)
    overlaps = []
    @events.reverse.each_with_index do |event_a, i|
      @events.reverse[i+1..-1].each_with_index do |event_b|
        if event_a.end_time > event_b.start_time && event_b.end_time > event_a.start_time
          overlaps << [event_a, event_b]
        end
      end
    end
    mult_conflicts = []
    overlaps.each do |overlap|
      # pull list of multiple conflics
      (overlaps - [overlap]).each do |other_overlap|
        if (other_overlap.include?(overlap.first) || other_overlap.include?(overlap.last)) && !(mult_conflicts.any? { |c| c.include?(overlap.first) && c.include?(overlap.last) && c.include?(other_overlap.first) && c.include?(other_overlap.last)})
          mult_conflicts << other_overlap
        end
      end
    end
    p mult_conflicts
  end 
end 

def main
  calendar = Calendar.new
  calendar.schedule(Event.new(1,
      Time.parse('2014-01-01 10:00'),
      Time.parse('2014-01-01 11:00')))
  calendar.schedule(Event.new(2,
      Time.parse('2014-01-01 11:00'),
      Time.parse('2014-01-01 12:00')))
  calendar.schedule(Event.new(3,
      Time.parse('2014-01-01 12:00'),
      Time.parse('2014-01-01 13:00')))
  calendar.schedule(Event.new(4,
      Time.parse('2014-01-02 10:00'),
      Time.parse('2014-01-02 11:00')))
  calendar.schedule(Event.new(5,
      Time.parse('2014-01-02 09:30'),
      Time.parse('2014-01-02 11:30')))
  calendar.schedule(Event.new(6,
      Time.parse('2014-01-02 08:30'),
      Time.parse('2014-01-02 12:30')))
  calendar.schedule(Event.new(7,
      Time.parse('2014-01-03 10:00'),
      Time.parse('2014-01-03 11:00')))
  calendar.schedule(Event.new(8,
      Time.parse('2014-01-03 09:30'),
      Time.parse('2014-01-03 10:30')))
  calendar.schedule(Event.new(9,
      Time.parse('2014-01-03 09:45'),
      Time.parse('2014-01-03 10:45')))
  #puts 
  calendar.find_conflicted_time_windows
  # should print {2014-01-02 09:30:00 -0800 - 2014-01-02 10:00:00 -0800: 
  # [6, 5]} {2014-01-02 10:00:00 -0800 - 2014-01-02 11:00:00 -0800: [6, 
  # 5, 4]} {2014-01-02 11:00:00 -0800 - 2014-01-02 11:30:00 -0800: [6, 
  # 5]} {2014-01-03 09:45:00 -0800 - 2014-01-03 10:00:00 -0800: [8, 9]} 
  # {2014-01-03 10:00:00 -0800 - 2014-01-03 10:30:00 -0800: [8, 9, 7]} 
  # {2014-01-03 10:30:00 -0800 - 2014-01-03 10:45:00 -0800: [9, 7]}
end 

if __FILE__ == $0
  main 
end
