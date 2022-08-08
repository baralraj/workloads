defmodule WorkloadsTest do
  use ExUnit.Case
  doctest Workloads

  alias Workloads.Loads.Fib
  alias Workloads.Loads.NatSquared

  test "first 10 fibs" do
    Fib.start_link(55)

    fibs =
      for _ <- 0..9 do
        Fib.next()
      end

    assert fibs == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
  end

  test "in 60sec need to get to 100requests via Fib" do
    Fib.start_link(100)

    fibs = Workloads.load(Fib, 60, 1, 100)

    assert fibs == [
             [duration: 5, target: 1],
             [duration: 5, target: 1],
             [duration: 5, target: 2],
             [duration: 5, target: 3],
             [duration: 5, target: 5],
             [duration: 5, target: 8],
             [duration: 6, target: 13],
             [duration: 6, target: 21],
             [duration: 6, target: 34],
             [duration: 6, target: 55],
             [duration: 6, target: 100]
           ]
  end

  test "first 10 squares" do
    NatSquared.start_link(100)

    squares =
      for _ <- 0..9 do
        NatSquared.next()
      end

    assert squares == [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
  end

  test "in 60sec need to get to 100requests via Squares of Nats" do
    NatSquared.start_link(100)

    squares = Workloads.load(NatSquared, 60, 1, 100)

    assert squares == [
             [duration: 6, target: 1],
             [duration: 6, target: 4],
             [duration: 6, target: 9],
             [duration: 6, target: 16],
             [duration: 6, target: 25],
             [duration: 6, target: 36],
             [duration: 6, target: 49],
             [duration: 6, target: 64],
             [duration: 6, target: 81],
             [duration: 6, target: 100]
           ]
  end
end
