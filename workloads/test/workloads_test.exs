defmodule WorkloadsTest do
  use ExUnit.Case
  doctest Workloads

  alias Workloads.Loads.Exp
  alias Workloads.Loads.Log
  alias Workloads.Loads.Fib
  alias Workloads.Loads.NatSquared

  ####################
  ###   FIB SEQUENCE
  ####################

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

  test "in 60sec need to get to 600requests from 500 via Fib" do
    Fib.start_link(600)

    fibs = Workloads.load(Fib, 60, 500, 600)

    assert fibs == [
             [duration: 5, target: 500],
             [duration: 5, target: 501],
             [duration: 5, target: 502],
             [duration: 5, target: 503],
             [duration: 5, target: 505],
             [duration: 5, target: 508],
             [duration: 6, target: 513],
             [duration: 6, target: 521],
             [duration: 6, target: 534],
             [duration: 6, target: 555],
             [duration: 6, target: 600]
           ]
  end

  ########################
  ###   SQUARES SEQUENCE
  ########################

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

  test "in 60sec need to get to 500requests to 600 via Squares of Nats" do
    NatSquared.start_link(100)

    squares = Workloads.load(NatSquared, 60, 500, 600)

    assert squares == [
             [duration: 6, target: 500],
             [duration: 6, target: 504],
             [duration: 6, target: 509],
             [duration: 6, target: 516],
             [duration: 6, target: 525],
             [duration: 6, target: 536],
             [duration: 6, target: 549],
             [duration: 6, target: 564],
             [duration: 6, target: 581],
             [duration: 6, target: 600]
           ]
  end


  ####################
  ###   LOG SEQUENCE
  ####################

  test "in 60sec need to get to 100requests via Log" do
    Log.start_link(50)

    logs = Workloads.load(Log, 60, 1, 100)

    assert logs == [
             [duration: 10, target: 1],
             [duration: 10, target: 54], # 53
             [duration: 10, target: 69], # 15
             [duration: 10, target: 80], # 11
             [duration: 10, target: 89], # 9
             [duration: 10, target: 100] # 11
           ]
  end

  test "in 60sec need to get to 600requests from 500 via Log" do
    Log.start_link(50)

    logs = Workloads.load(Log, 60, 500, 600)

    assert logs == [
             [duration: 10, target: 500],
             [duration: 10, target: 554], # 53
             [duration: 10, target: 569], # 15
             [duration: 10, target: 580], # 11
             [duration: 10, target: 589], # 9
             [duration: 10, target: 600]  # 11
           ]
  end

  ##########################
  ###   Multiple Sequences
  ##########################

  test "in 60sec: 400 -> 500 via Fib, 500 -> 600 via Log" do
    Fib.start_link(50)
    Log.start_link(50)

    fibs = Workloads.load(Fib, 30, 400, 500)

    logs = Workloads.load(Log, 30, 500, 600)

    expected = [
      [duration: 2, target: 400],
      [duration: 2, target: 401],
      [duration: 2, target: 402],
      [duration: 3, target: 403],
      [duration: 3, target: 405],
      [duration: 3, target: 408],
      [duration: 3, target: 413],
      [duration: 3, target: 421],
      [duration: 3, target: 434],
      [duration: 3, target: 455],
      [duration: 3, target: 500],
      [duration: 5, target: 554],
      [duration: 5, target: 569],
      [duration: 5, target: 580],
      [duration: 5, target: 589],
      [duration: 5, target: 600]
    ]

    assert (fibs ++ tl(logs)) == expected
  end

  test "in 60sec: 400 -> 500 via Exp, 500 -> 600 via Log" do
    Exp.start_link(50)
    Log.start_link(50)

    exps = Workloads.load(Exp, 30, 400, 500)

    logs = Workloads.load(Log, 30, 500, 600)

    expected = [
      [duration: 5, target: 400],
      [duration: 5, target: 404],
      [duration: 5, target: 408],
      [duration: 5, target: 416],
      [duration: 5, target: 432],
      [duration: 5, target: 500],
      [duration: 5, target: 554],
      [duration: 5, target: 569],
      [duration: 5, target: 580],
      [duration: 5, target: 589],
      [duration: 5, target: 600]
    ]

    assert (exps ++ tl(logs)) == expected
  end

end
