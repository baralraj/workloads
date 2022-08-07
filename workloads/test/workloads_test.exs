defmodule WorkloadsTest do
  use ExUnit.Case
  doctest Workloads

  alias Workloads.Loads.Fib

  test "first 10 fibs" do
    # Workloads.load(Fib, 60, 1, 55)
    Fib.start_link(55)

    fibs =
      for _ <- 0..9 do
        Fib.next()
      end

    assert fibs == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
  end

  test "options with first 10 fibs" do
    Fib.start_link(55)

    fibs = Workloads.load(Fib, 60, 1, 55)

    assert fibs == [
             [duration: 6, target: 1],
             [duration: 6, target: 1],
             [duration: 6, target: 2],
             [duration: 6, target: 3],
             [duration: 6, target: 5],
             [duration: 6, target: 8],
             [duration: 6, target: 13],
             [duration: 6, target: 21],
             [duration: 6, target: 34],
             [duration: 6, target: 55]
           ]
  end
end
