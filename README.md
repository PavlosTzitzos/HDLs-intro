# Verilog-Code

This repository is an effort to make an introduction in SystemVerilog.

Start from Verilog folder first:

```mermaid
graph TD;
    Verilog-->SystemVerilog;
    Verilog-->Verilog-A;
    Verilog-A-->Verilog-AMS;
    SystemVerilog-->SystemVerilog-AMS;
    Verilog-AMS-->SystemVerilog-AMS;
```

Basic differences
-----------------
Verilog (HDL | digital | Icarus Verilog)

- modules

  - input/output/inout

  - reg/wire

  - always block

  - assign

- testbenches(also modules)

  - timescale

  - always block for clk

  - initial block

SystemVerilog (HDL | digital | Modelsim)

- modules

  - input/output/inout (do not use: inout)

  - reg/wire/logic (use: logic)

  - always/ always_comb/always_ff blocks (do not use: always block)

  - assign

- testbenches(also modules)

  - timescale (do not use)

  - always block for clk (prefer this)

  - initial block

  - task

Verilog-A (analog | SPICE simulator)

- modules

  - input/output/inout

  - electrical

  - analog / analog function blocks (prefer: analog block)

  - assign

- testbench is a circuit (must be drawn)

Verilog-AMS (analog + digital | ADMS simulator)

- modules

  - input/output/inout

  - reg/wire/electrical

  - always/ always_comb/always_ff blocks (do not use: always block)

  - analog / analog function blocks (prefer: analog block)

  - assign

- include :

  - constants.vams

  - disciplines.vams

- testbench is a circuit (must be drawn)

Sources that helped me starting learning HDL:

|  No. |                          Sources                              |       Verilog      |    SystemVerilog   |        UVM         |        VHDL        |      SystemC       | 
|:----:|:-------------------------------------------------------------:|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:| 
|   1  | https://fpgatutorial.com/                                     | :heavy_check_mark: | :heavy_check_mark: |                    | :heavy_check_mark: | :heavy_check_mark: | 
|   2  | https://www.doulos.com/knowhow/                               | :heavy_check_mark: | :heavy_check_mark: |                    | :heavy_check_mark: | :heavy_check_mark: | 
|   3  | https://verificationguide.com/                                |                    | :heavy_check_mark: | :heavy_check_mark: |                    | :heavy_check_mark: | 
|   4  | https://www.chipverify.com/                                   | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |                    |                    | 
|   5  | https://www.systemverilog.in/p/systemverilog-tutorial.html    |                    | :heavy_check_mark: | :heavy_check_mark: |                    |                    | 
|   6  | https://www.fpga4student.com/                                 | :heavy_check_mark: |                    |                    | :heavy_check_mark: |                    | 
|   7  | https://github.com/JeffDeCola/my-verilog-examples             | :heavy_check_mark: |                    |                    |                    |                    | 
|   8  | https://systemverilogdesign.com/tag/multiply/                 | :heavy_check_mark: | :heavy_check_mark: |                    |                    |                    | 
|   9  | Digital Design , M. Morris Mano and Michael Ciletti , 6th Ed. | :heavy_check_mark: | :heavy_check_mark: |                    | :heavy_check_mark: |                    | 
|  10  | Digital Design , William J. Dally and R. Curtis Harting       |                    | :heavy_check_mark: |                    |                    |                    | 
|  ... |                            ...                                |         ...        |         ...        |        ...         |         ...        |         ...        | 



Additional information:

1. Configuration instructions:
    * No configurations necessary.

2. Installation instructions:
    * I am using VisualStudioCode extensions:
        + https://github.com/mshr-h/vscode-verilog-hdl-support
        + https://www.wavetrace.io/
    * Also I work with Icarus Verilog:
        + official site: http://iverilog.icarus.com/
        + download for windows: https://sourceforge.net/projects/iverilog/
        + other guides: https://iverilog.fandom.com/wiki/Installation_Guide (old)
        + new : https://steveicarus.github.io/iverilog/index.html
3. Operating instructions:
    * Add Icarus Verilog to PATH.
    * Always use flag: -g2012 
4. A file manifest (list of files included):
    <details>
    <summary>Verilog</summary>
        <p> >   intro</p>
        <p> >   tutorial</p>
    </details>

    <details>
    <summary>Verilog-A</summary>
        <p> >   intro</p>
        <p> >   tutorial</p>
    </details>
    
    <details>
    <summary>Verilog-AMS</summary>
        <p> >   intro</p>
        <p> >   tutorial</p>
    </details>
    
    <details>
    <summary>SystemVerilog</summary>
        <p> >   course-material</p>
        <p> >   tutorial</p>
        <p> >   projects</p>
    </details>
    
5. Copyright and licensing information:
    * See sources table.
6. Contact information:
    * git 
    * mail
7. Known bugs:
    * No bugs yet.
8. Troubleshooting:
    * See each folder.
9. ToDo list:
- [ ] Fix folders
- [ ] Add simple examples
- [ ] add basic modules
- [ ] add comments
- [ ] add testbenches with multiple tests and add explaination
- [ ] complete the readme files
- [ ] find projects and create folders with readme files explaining the project



