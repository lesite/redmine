# encoding: utf-8
require File.expand_path(File.dirname(__FILE__)) + '/../test_helper'

# This file is generated by the Ruby Holiday gem.
#
# Definitions loaded: data/se.yaml
class SeDefinitionTests < Test::Unit::TestCase  # :nodoc:

  def test_se
{Date.civil(2008,1,1) => 'Nyårsdagen', 
 Date.civil(2008,1,6) => 'Trettondedag jul',
 Date.civil(2008,3,21) => 'Långfredagen', 
 Date.civil(2008,3,23) => 'Påskdagen', 
 Date.civil(2008,3,24) => 'Annandag påsk',
 Date.civil(2008,5,1) => 'Första maj',
 Date.civil(2008,5,1) => 'Kristi himmelsfärdsdag',
 Date.civil(2008,5,11) => 'Pingstdagen',
 Date.civil(2008,6,6) => 'Nationaldagen',
 Date.civil(2005,6,25) => 'Midsommardagen',
 Date.civil(2006,6,24) => 'Midsommardagen',
 Date.civil(2007,6,23) => 'Midsommardagen',
 Date.civil(2008,6,21) => 'Midsommardagen',
 Date.civil(2005,11,5) => 'Alla helgons dag',
 Date.civil(2006,11,4) => 'Alla helgons dag',
 Date.civil(2007,11,3) => 'Alla helgons dag',
 Date.civil(2008,11,1) => 'Alla helgons dag',
 Date.civil(2008,12,25) => 'Juldagen',
 Date.civil(2008,12,26) => 'Annandag jul'}.each do |date, name|
  assert_equal name, (Holidays.on(date, :se, :informal)[0] || {})[:name]
end
  end
end
