defmodule Workloads do
  def targets_in_range(gen, from, to, acc) do
    next = gen.next()

    cond do
      next < from -> targets_in_range(gen, from, to, acc)
      next <= to -> targets_in_range(gen, from, to, [next | acc])
      true -> acc
    end
  end

  def load(gen, duration, from, to) do
    targets = targets_in_range(gen, from, to, [])

    no_of_bins = length(targets)

    bin_duration =
      case div(duration, no_of_bins) do
        0 -> 1
        x -> x
      end

    remainder = rem(duration, no_of_bins)

    {_, options} =
      targets
      |> Enum.with_index()
      |> Enum.reduce({remainder, []}, fn
        {target, i}, {r, acc} ->
          target =
            cond do
              i == 0 -> to
              i == no_of_bins - 1 -> from
              true -> target
            end

          inc = if 0 < r, do: 1, else: 0
          {r - 1, [[duration: bin_duration + inc, target: target] | acc]}
      end)

    options
  end
end
