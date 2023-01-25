Mealy FSM:
----------

Given the followng FSM write the SystemVerilog module and testbench

```mermaid
stateDiagram
    [*] --> Still
    Still --> [*]

    Still --> Moving
    Moving --> Still
    Moving --> Crash
    Crash --> [*]
```
