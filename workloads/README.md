# Workloads

If you are using (k6)[https://k6.io/] for your load testing, you will
want some pre-defined load *curves*.

The following are curves that are progressively steep, meaning the
ramp to the desired load steeper. Another way to say this is that
the curves can be considered *spikier*:

* Naturals <img src="linear.png" width=32>
* Naturals Squared <img src="sqr.png" width=32>
* Fibonnaci <img src="fib.png" width=32>
* Exponential (2**N) <img src="exp.png" width=32>

The following curves put the greater load early and then ramp
slower to the desired load:

* Log <img src="log.png" width=32>

## Installation


```elixir
def deps do
  [
    {:workloads, github: "czrpb/workloads", sparse: "workloads"}
  ]
end
```
