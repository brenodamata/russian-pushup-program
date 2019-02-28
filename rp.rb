require 'pry'

class Week
  WEEK_ONE = {
    D1: {percentage: 30, interval: 60},
    D2: {percentage: 50, interval: 60},
    D3: {percentage: 60, interval: 45},
    D4: {percentage: 25, interval: 60},
    D5: {percentage: 45, interval: 30},
    D6: {percentage: 40, interval: 60},
    D7: {percentage: 20, interval: 90}
  }
  WEEK_TWO = {
    D1: {percentage: 35, interval: 45},
    D2: {percentage: 55, interval: 20},
    D3: {percentage: 30, interval: 15},
    D4: {percentage: 65, interval: 60},
    D5: {percentage: 35, interval: 45},
    D6: {percentage: 45, interval: 60},
    D7: {percentage: 25, interval: 120}
  }

  attr_accessor :week, :orm

  def initialize week, one_rep_max
    @week = unless week && week != :one
      WEEK_ONE
    else
      WEEK_TWO
    end

    @orm = one_rep_max.to_f
  end

  def schedule
    @week.each_with_object({}) do |day, hsh|
      percentage = day.last[:percentage] / 100.0
      num_pushups = (@orm * percentage).ceil
      hsh[day.first] = "#{num_pushups} every #{day.last[:interval]} minutes"
    end
  end

  def total_per_day
    @week.each_with_object({}) do |day, hsh|
      percentage = day.last[:percentage] / 100.0
      num_pushups = (@orm * percentage).ceil
      sets = 960.0 / day.last[:interval]
      total_pushups = num_pushups * sets
      hsh[day.first] = total_pushups.to_i
    end
  end
end

w1 = Week.new(nil, 60)
s = w1.schedule
h = w1.total_per_day

w2 = Week.new(:two, 60)
s2 = w2.schedule
h2 = w2.total_per_day

pry
