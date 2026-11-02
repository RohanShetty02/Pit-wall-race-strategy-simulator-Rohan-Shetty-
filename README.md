# Pit Wall: Race Strategy & Pit Window Risk Simulator

A MATLAB model that asks the question a race engineer asks on the pit wall: **when should the car pit, and how many times?** It also includes a real-data analysis of Kimi Antonelli's 2025 and 2026 qualifying laps, to look for the effect of the 2026 electric power rules.

## What's in here

| Part | Files | What it does |
| --- | --- | --- |
| Lap simulator | `lapsim.m` | Speed limit at every metre of a 600 m track with one corner, forward and backward passes, lap time |
| Race model | `raceTime.m` | 50 laps with tyre grip decay, fuel mass, pit stops and three tyre compounds |
| Strategy sweeps | `PitSweep.m`, `PitSweep2.m`, `Compound_Sweep.m` | Best pit lap, one stop vs two stops, tyre order |
| Safety car risk | `RiskSweep.m` | 5,000 random races comparing a fixed plan with one that reacts to a safety car |
| Graphs | `Graph.m`, `StopCostGraph.m` | Plots used in the write-up |
| Telemetry | `ant_*_q.csv`, `*_straights_table.csv` | OpenF1 qualifying laps for Monza and Montreal, 2025 and 2026, and per-straight power results |

## Main results (model with assumed tyre values, not team data)

- One stop wins over no stop or two stops at a 20 s pit loss. A second stop only pays if a stop costs less than about 8.9 s.
- The choice of tyre pair moves race time by 3 to 6 s more than the order does. The harder tyre first is faster by 0.1 to 0.2 s.
- Reacting to a safety car saves about 1.1 to 1.3 s on average. It only applies in about 1 race in 6, and in those races it saves roughly 7 s or more.

## Real telemetry: 2025 vs 2026

Method: speed from OpenF1 (about 3.7 samples per second), acceleration from the speed trace, and specific power = v × (a + k × v²) with a drag constant k of 6.5e-4 for both cars.

- On the long straights at Monza the 2026 car starts stronger but loses 26 to 49% of its power by the end, against 5 to 22% for the 2025 car.
- The same pattern shows at Montreal (60 to 66% against 24 to 43%).
- This is consistent with the 2026 electric energy budget running out along a straight ("superclipping"), but it is not proven, because battery data is not public.

## Limits

Only one lap per driver, per circuit, per year, from different qualifying sessions. Drag was measured from seven coast samples, not known. Car mass was assumed to be 800 kg. The cars differ in more than the engine. Only the shape of the power curves is meaningful, not their absolute level.

## Data source

[OpenF1](https://openf1.org), free historical data. Rules context from press reports.

## How to run

Open the `.m` files in MATLAB (MATLAB Online works). Run `PitSweep.m`, `PitSweep2.m`, `Compound_Sweep.m` or `RiskSweep.m` from the same folder as `lapsim.m` and `raceTime.m`. The telemetry notebook is in Python (Google Colab).
