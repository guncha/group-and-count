require "minitest/autorun"
require "./group_and_count"

class GroupAndCountTest < MiniTest::Test
  def data
    [
      { event: 'bill.split', user: 'Ray Green', city: 'Boston', time_of_day: 'morning', timestamp: 23981398 },
      { event: 'promo.used', user: 'Jon Wicks', city: 'New York', time_of_day: 'afternoon', amount: 10.0, timestamp: 93219323 },
      { event: 'promo.used', user: 'Robin Chou', city: 'New York', time_of_day: 'afternoon', amount: 15.0, timestamp: 28138233 },
      { event: 'bill.split', user: 'John Malcom', city: 'Chicago', time_of_day: 'evening', timestamp: 32189389 },
      { event: 'bill.split', user: 'Mark Wang', city: 'Boston', time_of_day: 'evening', timestamp: 43890121 }
    ]
  end

  def test_count

    assert_equal(
      {"bill.split" => 3, "promo.used" => 2},
      GroupAndCount.group_and_count(data, :event))

    assert_equal(
      {},
      GroupAndCount.group_and_count(data, :some_other_key))

  end

  def test_nested_count

    assert_equal(
      {"bill.split"=>{"morning"=>1, "evening"=>2}, "promo.used"=>{"afternoon" => 2}},
      GroupAndCount.group_and_count(data, :event, :time_of_day))

    assert_equal(
      {"bill.split"=>{"Boston"=>{"morning"=>1, "evening"=>1}, "Chicago"=>{"evening"=>1}}, "promo.used"=>{"New York"=>{"afternoon"=>2}}},
      GroupAndCount.group_and_count(data, [:event, :city, :time_of_day]))

  end
end