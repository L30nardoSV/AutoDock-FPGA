In order to estimate power, it is possible to use `Power Play`.

First go inside the folder generated by AOC:

```zsh
[lvs@celebdil docking]$ pwd       
/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/bin_hw/docking
```

Then run:

```zsh
quartus_pow top.qpf
```

The output will be large. Here is an extract of the initial output and final results:


```zsh
Info: *******************************************************************
Info: Running Quartus Prime PowerPlay Power Analyzer
    Info: Version 16.0.2 Build 222 07/20/2016 Patches 2.06 SJ Pro Edition
    Info: Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
    Info: Your use of Altera Corporation's design tools, logic functions 
    Info: and other software and tools, and its AMPP partner logic 
    Info: functions, and any output files from any of the foregoing 
    Info: (including device programming or simulation files), and any 
    Info: associated documentation or information are expressly subject 
    Info: to the terms and conditions of the Altera Program License 
    Info: Subscription Agreement, the Altera Quartus Prime License Agreement,
    Info: the Altera MegaCore Function License Agreement, or other 
    Info: applicable license agreement, including, without limitation, 
    Info: that your use is for the sole purpose of programming logic 
    Info: devices manufactured by Altera and sold by Altera or its 
    Info: authorized distributors.  Please refer to the applicable 
    Info: agreement for further details.
    Info: Processing started: Tue Sep 26 09:46:09 2017
Info: Command: quartus_pow top.qpf
Info: Using INI file /home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/bin_hw/docking/quartus.ini
Info (16677): Loading final database
Info (16734): Loading "final" snapshot for partition "|".
Info (16734): Loading "final" snapshot for partition "auto_fab_0".
Info (16734): Loading "final" snapshot for partition "inst_ccip_interface_reg|inst_green_top|inst_ccip_std_afu|u0|freeze_wrapper_inst|kernel_wrapper_inst".



...


Warning (222013): Relative toggle rates could not be calculated because no clock domain could be identified for some nodes
Info (223001): Completed Vectorless Power Activity Estimation
load protobufWarning (218006): Current setting of the Programmable Power Technology Optimization logic option forces all tiles with failing timing paths to high speed
Info (218000): Using Advanced I/O Power to simulate I/O buffers with the specified board trace model
Warning (215044): No board thermal model was selected.  Analyzing without board thermal modeling.
Info (18289): Started post-fitting delay annotation
Warning (18291): Timing characteristics of device 10AX115U3F45E2SGE3 are preliminary
Info (18290): Delay annotation completed successfully
Info (215049): Average toggle rate for this design is 24.120 millions of transitions / sec
Info (215031): Total thermal power estimate for the design is 29551.61 mW
Info: Quartus Prime PowerPlay Power Analyzer was successful. 0 errors, 252 warnings
    Info: Peak virtual memory: 22580 megabytes
    Info: Processing ended: Tue Sep 26 10:02:07 2017
    Info: Elapsed time: 00:15:58
    Info: Total CPU time (on all processors): 00:27:15
```