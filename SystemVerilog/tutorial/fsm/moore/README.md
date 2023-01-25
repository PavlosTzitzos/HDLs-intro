Moore FSM:
----------

Given the followng FSM write the SystemVerilog module and testbench

```mermaid
stateDiagram
    [reset] --> sIdle
    sIdle --> sIdle : token=0/clrt=0 , spray=0
    sIdle --> sToken : token=1/clrt=1 , spray=1
    sToken --> sSpray
    sSpray --> sSpray : tdone=0/clrt=0 , spray=1
    sSpray --> sIdle : tdone=1
```
