Mealy FSM:
----------

Given the followng FSM write the SystemVerilog module and testbench

```mermaid
stateDiagram
    S0 --> S0 : 0/0
    S0 --> S1 : 1/0
    S1 --> S1 : 1/0
    S1 --> S2 : 0/0
    S2 --> S1 : 1/1
    S2 --> S0 : 0/0
```
