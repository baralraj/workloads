# Workloads

## `k6`'s Problem

If you are using [k6](https://k6.io/) for your load testing, you will
want some pre-defined load *curves*.

But, it seems you have to define your
own:

https://k6.io/docs/using-k6/scenarios/

https://k6.io/docs/using-k6/k6-options/reference/#stages

```javascript
export const options = {
  stages: [
    { duration: '3m', target: 10 },
    { duration: '5m', target: 10 },
    { duration: '10m', target: 35 },
    { duration: '3m', target: 0 },
  ],
};
```

## Solution

The following are curves that are progressively steep, meaning the
ramp to the desired load is steeper.
Another way to say this is that
the curves can be considered *spikier*:

* <img src="linear.png" width=32> Naturals
* <img src="sqr.png" width=32> Naturals Squared
* <img src="fib.png" width=32> Fibonnaci
* <img src="exp.png" width=32> Exponential (2**N)

The following curves put the greater load early and then ramp
slower to the desired load:

* <img src="log.png" width=32> Log

## Installation

In your `mix.exs` file:

```elixir
def deps do
  [
    {:workloads, github: "czrpb/workloads", sparse: "workloads"}
  ]
end
```

Via `Mix.install`:

```elixir
Mix.install([
  {:workloads, github: "czrpb/workloads", sparse: "workloads"}
])