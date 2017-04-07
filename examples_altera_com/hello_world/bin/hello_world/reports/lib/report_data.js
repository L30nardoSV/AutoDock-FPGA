var loopsJSON={
  "columns":["Pipelined", "II", "Bottleneck"]
  , "functions":
  [
  ]
}
;var mavJSON={
  "nodes":
  [
    {
      "type":"kernel"
      , "id":8
      , "name":"hello_world"
      , "file":""
      , "line":"0"
      , "children":[
        {
          "type":"bb"
          , "id":3
          , "name":"Block0"
          , "file":""
          , "line":"0"
          , "children":[
            {
              "type":"inst"
              , "id":4
              , "name":"Store"
              , "file":"1"
              , "line":"29"
              , "details":
              {
                "Width":"256 bits"
                , "Type":"Burst-non-aligned"
                , "Stall-free":"No"
                , "Start-Cycle":"4"
                , "Latency":"4"
              }
            }
            , {
              "type":"inst"
              , "id":5
              , "name":"end"
              , "file":"1"
              , "line":"31"
              , "details":
              {
                "Start-Cycle":"8"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":6
              , "name":"begin"
              , "file":""
              , "line":""
              , "details":
              {
                "Start-Cycle":"0"
                , "Latency":"1"
                , "Additional Info":"Entrance to a basic block. Control flow comes to this node from one or more branch nodes, unless it's the very first merge node in a kernel. There is no control branching between merge and branch node within the same basic block."
              }
            }
          ]
          , "details":
          {
            "Latency":"9"
          }
        }
      ]
    }
    , {
      "type":"memtype"
      , "id":9
      , "name":"Global Memory"
      , "file":""
      , "line":"0"
      , "children":[
        {
          "type":"memsys"
          , "id":10
          , "name":"DDR"
          , "file":""
          , "line":"0"
          , "replFactor":"0"
          , "banks":1
          , "pumping":0
          , "children":[
            {
              "type":"bank"
              , "id":11
              , "name":"Bank 0"
              , "file":""
              , "line":"0"
            }
          ]
        }
      ]
    }
  ]
  ,
  "links":
  [
    {
      "from":6
      , "to":4
    }
    ,
    {
      "from":4
      , "to":5
    }
    ,
    {
      "from":4
      , "to":11
    }
  ]
  , "fileIndexMap":
  {
    "/home/wimi/lvs/ofdock_altera/examples_altera_com/hello_world/device/hello_world.cl":"1"
  }
}
;var areaJSON={
  "columns":["ALUTs", "FFs", "RAMs", "DSPs"]
  , "debug_enabled":1
  , "total_percent":
  [17.056, 8.81534, 8.75768, 14.6639, 0]
  , "total":
  [69479, 138049, 349, 0]
  , "name":"Kernel System"
  , "max_resources":
  [788160, 1576320, 2380, 1518]
  , "partitions":
  [
    {
      "name":"Static Partition"
      , "resources":
      [
        {
          "name":"Board interface"
          , "data":
          [66240, 132480, 333, 0]
          , "details":
          [
            "Platform interface logic."
          ]
        }
      ]
    }
  ]
  , "resources":
  [
    {
      "name":"Board interface"
      , "data":
      [66240, 132480, 333, 0]
      , "details":
      [
        "Platform interface logic."
      ]
    }
  ]
  , "functions":
  [
    {
      "name":"hello_world"
      , "compute_units":1
      , "details":
      [
        "Number of compute units: 1"
      ]
      , "resources":
      [
        {
          "name":"Function overhead"
          , "data":
          [1570, 1505, 0, 0]
          , "details":
          [
            "Kernel dispatch logic."
          ]
        }
      ]
      , "basicblocks":
      [
        {
          "name":"Block0"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [118, 271, 0, 0]
              , "details":
              [
                "Resources for live values and control logic. To reduce this area:\n- reduce size of local variables\n- reduce scope of local variables, localizing them as much as possible\n- reduce number of nested loops"
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Control flow logic"
                    , "data":
                    [32, 32, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"hello_world.cl:29"
                    , "data":
                    [86, 239, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/examples_altera_com/hello_world/device/hello_world.cl"
                          , "line":29
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"No Source Line"
              , "data":
              [16, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":""
                    , "line":0
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Integer Compare"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"hello_world.cl:29"
              , "data":
              [1535, 3793, 16, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/examples_altera_com/hello_world/device/hello_world.cl"
                    , "line":29
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Store"
                    , "data":
                    [1535, 3793, 16, 0]
                    , "details":
                    [
                      "Store to global memory that implements printf functionality. printf is a debug tool that may slow down overall system performance. Remove from production code."
                    ]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
;var fileJSON=[{"index":0, "path":"/home/wimi/lvs/ofdock_altera/examples_altera_com/hello_world/device/hello_world.cl", "name":"hello_world.cl", "content":"// Copyright (C) 2013-2016 Altera Corporation, San Jose, California, USA. All rights reserved.\012// Permission is hereby granted, free of charge, to any person obtaining a copy of this\012// software and associated documentation files (the \"Software\"), to deal in the Software\012// without restriction, including without limitation the rights to use, copy, modify, merge,\012// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to\012// whom the Software is furnished to do so, subject to the following conditions:\012// The above copyright notice and this permission notice shall be included in all copies or\012// substantial portions of the Software.\012// \012// THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND,\012// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES\012// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND\012// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT\012// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,\012// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING\012// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR\012// OTHER DEALINGS IN THE SOFTWARE.\012// \012// This agreement shall be governed in all respects by the laws of the State of California and\012// by the laws of the United States of America.\012\012// AOC kernel demonstrating device-side printf call\012\012__kernel void hello_world(int thread_id_from_which_to_print_message) {\012  // Get index of the work item\012  unsigned thread_id = get_global_id(0);\012\012  if(thread_id == thread_id_from_which_to_print_message) {\012    printf(\"Thread #%u: Hello from Altera's OpenCL Compiler!\\n\", thread_id);\012  }\012}\012\012"}];