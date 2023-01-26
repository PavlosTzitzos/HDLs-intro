Moore FSM:
----------

Given the followng FSM write the SystemVerilog module and testbench

```mermaid
stateDiagram
    direction LR
    classDef rst fill:white,stroke-width:0px
    reset:::rst --> sIdle
    sIdle --> sIdle : token=0
    note left of sIdle
            clrt=0 , spray=0
    end note
    sIdle --> sToken : token=1
    note right of sToken
            clrt=1 , spray=1
    end note
    sToken --> sSpray
    sSpray --> sSpray : tdone=0
    note right of sSpray
            clrt=0 , spray=1
    end note
    sSpray --> sIdle : tdone=1
```
