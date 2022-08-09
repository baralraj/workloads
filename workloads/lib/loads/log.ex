defmodule Workloads.Loads.Log do
  use Agent

  def start_link(factor) do
    Agent.start_link(fn -> {factor, 1} end, name: __MODULE__)
  end

  def next do
    {factor, x} = Agent.get(__MODULE__, & &1)
    Agent.update(__MODULE__, fn {factor, x} -> {factor, x + 1} end)
    (:math.log(x) * factor) |> floor #round
  end

  def reset do
    {factor, _} = Agent.get(__MODULE__, & &1)
    Agent.update(__MODULE__, fn _ -> {factor, 1} end)
  end
end
