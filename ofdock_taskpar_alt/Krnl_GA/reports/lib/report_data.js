var loopsJSON={
  "columns":["Pipelined", "II", "Bottleneck"]
  , "functions":
  [
    {
      "name":"Block1"
      , "data":
      ["Yes", "1", "n/a"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_GA.cl"
            , "line":624
            , "level":0
          }
        ]
      ]
    }
    , {
      "name":"Block5"
      , "data":
      ["No", "n/a", "n/a"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_Conform.cl"
            , "line":40
            , "level":0
          }
        ]
      ]
      , "details":
      [
        "Unresolvable exit condition"      ]
      , "resources":
      [
        {
          "name":"Loop exit condition unresolvable at iteration initiation."
        }
        , {
          "name":"See Nested Loops for more information."
        }
      ]
    }
    , {
      "name":"Block6"
      , "data":
      ["Yes", "1", "n/a"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_Conform.cl"
            , "line":47
            , "level":1
          }
        ]
      ]
    }
    , {
      "name":"Block8"
      , "data":
      ["Yes", "45", "II"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_Conform.cl"
            , "line":79
            , "level":1
          }
        ]
      ]
      , "details":
      [
        "Memory dependency and..."
      ]
      , "resources":
      [
        {
          "name":"II bottleneck due to memory dependency between: "
          , "subinfos":
          [
            {
              "info":
              {
                "name":"Load Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":96
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"Load Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":79
                    }
                    , {
                      "filename":"Krnl_Conform.cl"
                      , "line":234
                    }
                  ]
                ]
              }
            }
          ]
        }
        , {
          "name":"Largest critical path contributor(s):"
          , "subinfos":
          [
            {
              "info":
              {
                "name":"16%: Load Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":96
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"11%: Hardened Floating-Point Multiply-Add Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":188
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"11%: Hardened Floating-Point Multiply-Add Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":188
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Sub Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":129
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Multiply Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":174
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Sub Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":174
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Sub Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":174
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Multiply Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":188
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Sub Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":188
                    }
                  ]
                ]
              }
            }
          ]
        }
        , {
          "name":"II bottleneck due to memory dependency between: "
          , "subinfos":
          [
            {
              "info":
              {
                "name":"Load Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":96
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"Store Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":205
                    }
                  ]
                ]
              }
            }
          ]
        }
        , {
          "name":"Largest critical path contributor(s):"
          , "subinfos":
          [
            {
              "info":
              {
                "name":"16%: Load Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":96
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"11%: Hardened Floating-Point Multiply-Add Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":188
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"11%: Hardened Floating-Point Multiply-Add Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":188
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Sub Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":129
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Multiply Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":174
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Sub Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":174
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Sub Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":174
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Multiply Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":188
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":" 8%: Hardened Floating-Point Sub Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":188
                    }
                  ]
                ]
              }
            }
          ]
        }
        , {
          "name":"Additional dependency due to memory dependency between: "
          , "subinfos":
          [
            {
              "info":
              {
                "name":"Load Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":97
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"Load Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":79
                    }
                    , {
                      "filename":"Krnl_Conform.cl"
                      , "line":234
                    }
                  ]
                ]
              }
            }
          ]
        }
        , {
          "name":"Additional dependency due to memory dependency between: "
          , "subinfos":
          [
            {
              "info":
              {
                "name":"Load Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":97
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"Store Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":206
                    }
                  ]
                ]
              }
            }
          ]
        }
        , {
          "name":"Additional dependency due to memory dependency between: "
          , "subinfos":
          [
            {
              "info":
              {
                "name":"Load Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":98
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"Load Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":79
                    }
                    , {
                      "filename":"Krnl_Conform.cl"
                      , "line":234
                    }
                  ]
                ]
              }
            }
          ]
        }
        , {
          "name":"Additional dependency due to memory dependency between: "
          , "subinfos":
          [
            {
              "info":
              {
                "name":"Load Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":98
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"Store Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_Conform.cl"
                      , "line":207
                    }
                  ]
                ]
              }
            }
          ]
        }
      ]
    }
    , {
      "name":"Block9"
      , "data":
      ["Yes", "1", "n/a"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_Conform.cl"
            , "line":234
            , "level":1
          }
        ]
      ]
    }
    , {
      "name":"Block12"
      , "data":
      ["No", "n/a", "n/a"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_InterE.cl"
            , "line":55
            , "level":0
          }
        ]
      ]
      , "details":
      [
        "Unresolvable exit condition"      ]
      , "resources":
      [
        {
          "name":"Loop exit condition unresolvable at iteration initiation."
        }
        , {
          "name":"See Nested Loops for more information."
        }
      ]
    }
    , {
      "name":"Block13"
      , "data":
      ["Yes", "1", "n/a"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_InterE.cl"
            , "line":61
            , "level":1
          }
        ]
      ]
    }
    , {
      "name":"Block15"
      , "data":
      ["Yes", "13", "II"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_InterE.cl"
            , "line":87
            , "level":1
          }
        ]
      ]
      , "details":
      [
        "Data dependency"
      ]
      , "resources":
      [
        {
          "name":"II bottleneck due to data dependency on variable(s):"
          , "subinfos":
          [
            {
              "info":
              {
                "name":"interE"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_InterE.cl"
                      , "line":38
                    }
                  ]
                ]
              }
            }
          ]
        }
        , {
          "name":"Largest critical path contributor(s):"
          , "subinfos":
          [
            {
              "info":
              {
                "name":"40%: Hardened Floating-Point Multiply-Add Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_InterE.cl"
                      , "line":204
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"30%: Hardened Floating-Point Add Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_InterE.cl"
                      , "line":174
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"30%: Hardened Floating-Point Add Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_InterE.cl"
                      , "line":234
                    }
                  ]
                ]
              }
            }
          ]
        }
      ]
    }
    , {
      "name":"Block19"
      , "data":
      ["No", "n/a", "n/a"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_IntraE.cl"
            , "line":34
            , "level":0
          }
        ]
      ]
      , "details":
      [
        "Unresolvable exit condition"      ]
      , "resources":
      [
        {
          "name":"Loop exit condition unresolvable at iteration initiation."
        }
        , {
          "name":"See Nested Loops for more information."
        }
      ]
    }
    , {
      "name":"Block20"
      , "data":
      ["Yes", "1", "n/a"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_IntraE.cl"
            , "line":40
            , "level":1
          }
        ]
      ]
    }
    , {
      "name":"Block22"
      , "data":
      ["Yes", "17", "II"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_IntraE.cl"
            , "line":65
            , "level":1
          }
        ]
      ]
      , "details":
      [
        "Data dependency"
      ]
      , "resources":
      [
        {
          "name":"II bottleneck due to data dependency on variable(s):"
          , "subinfos":
          [
            {
              "info":
              {
                "name":"intraE"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_IntraE.cl"
                      , "line":32
                    }
                  ]
                ]
              }
            }
          ]
        }
        , {
          "name":"Largest critical path contributor(s):"
          , "subinfos":
          [
            {
              "info":
              {
                "name":"30%: Hardened Floating-Point Multiply-Add Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_IntraE.cl"
                      , "line":115
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"23%: Hardened Floating-Point Add Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_IntraE.cl"
                      , "line":101
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"23%: Hardened Floating-Point Sub Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_IntraE.cl"
                      , "line":104
                    }
                    , {
                      "filename":"Krnl_IntraE.cl"
                      , "line":106
                    }
                  ]
                ]
              }
            }
            , {
              "info":
              {
                "name":"23%: Hardened Floating-Point Add Operation"
                , "debug":
                [
                  [
                    {
                      "filename":"Krnl_IntraE.cl"
                      , "line":109
                    }
                  ]
                ]
              }
            }
          ]
        }
      ]
    }
    , {
      "name":"Block26"
      , "data":
      ["Yes", "1", "n/a"]
      , "debug":
      [
        [
          {
            "filename":"Krnl_Store.cl"
            , "line":30
            , "level":0
          }
        ]
      ]
    }
  ]
}
;var mavJSON={
  "nodes":
  [
    {
      "type":"kernel"
      , "id":24
      , "name":"Krnl_GA"
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
              , "id":6
              , "name":"Store"
              , "file":"1"
              , "line":"615"
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
              , "id":7
              , "name":"end"
              , "file":"1"
              , "line":"624"
              , "details":
              {
                "Start-Cycle":"8"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":8
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
        , {
          "type":"bb"
          , "id":4
          , "name":"Block1"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":""
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"No"
          , "isPipelined":"Yes"
          , "children":[
            {
              "type":"inst"
              , "id":9
              , "name":"Channel Write"
              , "file":"1"
              , "line":"625"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"39"
                , "Stall-free":"No"
                , "Start-Cycle":"10"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":11
              , "name":"loop end"
              , "file":"1"
              , "line":"624"
              , "details":
              {
                "Start-Cycle":"11"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":12
              , "name":"loop"
              , "file":""
              , "line":""
              , "loopTo":11
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
            "Latency":"12"
          }
        }
        , {
          "type":"bb"
          , "id":5
          , "name":"Block2"
          , "file":""
          , "line":"0"
          , "children":[
            {
              "type":"inst"
              , "id":13
              , "name":"Channel Write"
              , "file":"1"
              , "line":"627"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"48"
                , "Stall-free":"No"
                , "Start-Cycle":"4"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":15
              , "name":"Channel Write"
              , "file":"1"
              , "line":"628"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"0"
                , "Stall-free":"No"
                , "Start-Cycle":"4"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":17
              , "name":"Channel Write"
              , "file":"1"
              , "line":"629"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"0"
                , "Stall-free":"No"
                , "Start-Cycle":"4"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":19
              , "name":"Store"
              , "file":"1"
              , "line":"633"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"1"
                , "Latency":"4"
              }
            }
            , {
              "type":"inst"
              , "id":20
              , "name":"Store"
              , "file":"1"
              , "line":"634"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"1"
                , "Latency":"4"
              }
            }
            , {
              "type":"inst"
              , "id":21
              , "name":"end"
              , "file":"1"
              , "line":"640"
              , "details":
              {
                "Start-Cycle":"5"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":22
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
            "Latency":"6"
          }
        }
      ]
    }
    , {
      "type":"kernel"
      , "id":100
      , "name":"Krnl_Conform"
      , "file":""
      , "line":"0"
      , "children":[
        {
          "type":"bb"
          , "id":29
          , "name":"Block3.wii_blk"
          , "file":""
          , "line":"0"
          , "children":[
            {
              "type":"inst"
              , "id":37
              , "name":"Load"
              , "file":"2"
              , "line":"79"
              , "details":
              {
                "Width":"256 bits"
                , "Type":"Simple"
                , "Stall-free":"No"
                , "Start-Cycle":"2"
                , "Latency":"1"
                , "Additional Info":" This operation is work-item invariant -- it performs the same operation for all threads in the kernel."
              }
            }
            , {
              "type":"inst"
              , "id":38
              , "name":"Load"
              , "file":"2"
              , "line":"155"
              , "details":
              {
                "Width":"256 bits"
                , "Type":"Simple"
                , "Stall-free":"No"
                , "Start-Cycle":"4"
                , "Latency":"1"
                , "Additional Info":" This operation is work-item invariant -- it performs the same operation for all threads in the kernel."
              }
            }
            , {
              "type":"inst"
              , "id":39
              , "name":"end"
              , "file":"0"
              , "line":"0"
              , "details":
              {
                "Start-Cycle":"6"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":40
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
            "Latency":"7"
          }
        }
        , {
          "type":"bb"
          , "id":30
          , "name":"Block4"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":"Exit which branches back to loop. "
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"Yes"
          , "isPipelined":"No"
          , "details":
          {
            "Latency":"2"
          }
        }
        , {
          "type":"bb"
          , "id":31
          , "name":"Block5"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":"Entry to loop. "
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"Yes"
          , "isPipelined":"No"
          , "loopTo":30
          , "details":
          {
            "Latency":"2"
          }
        }
        , {
          "type":"bb"
          , "id":32
          , "name":"Block6"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":""
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"No"
          , "isPipelined":"Yes"
          , "children":[
            {
              "type":"inst"
              , "id":41
              , "name":"Channel Read"
              , "file":"2"
              , "line":"48"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"39"
                , "Stall-free":"No"
                , "Start-Cycle":"10"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":42
              , "name":"Store"
              , "file":"2"
              , "line":"48"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"11"
                , "Latency":"2"
              }
            }
            , {
              "type":"inst"
              , "id":43
              , "name":"loop end"
              , "file":"2"
              , "line":"47"
              , "details":
              {
                "Start-Cycle":"13"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":44
              , "name":"loop"
              , "file":""
              , "line":""
              , "loopTo":43
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
            "Latency":"14"
          }
        }
        , {
          "type":"bb"
          , "id":33
          , "name":"Block7"
          , "file":""
          , "line":"0"
          , "children":[
            {
              "type":"inst"
              , "id":45
              , "name":"Channel Read"
              , "file":"2"
              , "line":"51"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"48"
                , "Stall-free":"No"
                , "Start-Cycle":"49"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":46
              , "name":"Channel Read"
              , "file":"2"
              , "line":"54"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"0"
                , "Stall-free":"No"
                , "Start-Cycle":"1"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":47
              , "name":"Channel Read"
              , "file":"2"
              , "line":"55"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"0"
                , "Stall-free":"No"
                , "Start-Cycle":"1"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":48
              , "name":"Load"
              , "file":"2"
              , "line":"59"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"2"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":49
              , "name":"Load"
              , "file":"2"
              , "line":"60"
              , "details":
              {
                "Width":"64 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"2"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":50
              , "name":"Load"
              , "file":"2"
              , "line":"110"
              , "details":
              {
                "Width":"64 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"47"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":51
              , "name":"Load"
              , "file":"2"
              , "line":"112"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"2"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":52
              , "name":"Store"
              , "file":"2"
              , "line":"52"
              , "details":
              {
                "Width":"256 bits"
                , "Type":"Burst-non-aligned"
                , "Stall-free":"No"
                , "Start-Cycle":"53"
                , "Latency":"4"
              }
            }
            , {
              "type":"inst"
              , "id":53
              , "name":"end"
              , "file":"2"
              , "line":"79"
              , "details":
              {
                "Start-Cycle":"57"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":54
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
            "Latency":"58"
          }
        }
        , {
          "type":"bb"
          , "id":34
          , "name":"Block8"
          , "file":""
          , "line":"0"
          , "II":45
          , "LoopInfo":"Loop is pipelined with II of 45. See Optimization Report for more information."
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"No"
          , "isPipelined":"Yes"
          , "children":[
            {
              "type":"inst"
              , "id":55
              , "name":"Load"
              , "file":"2"
              , "line":"81"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Prefetching"
                , "Stall-free":"No"
                , "Start-Cycle":"3"
                , "Latency":"3"
              }
            }
            , {
              "type":"inst"
              , "id":56
              , "name":"Load"
              , "file":"2"
              , "line":"121"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"9"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":57
              , "name":"Load"
              , "file":"2"
              , "line":"118"
              , "details":
              {
                "Width":"128 bits"
                , "Type":"Burst-non-aligned"
                , "Stall-free":"No"
                , "Start-Cycle":"19"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":58
              , "name":"Load"
              , "file":"2"
              , "line":"123"
              , "details":
              {
                "Width":"128 bits"
                , "Type":"Burst-non-aligned"
                , "Stall-free":"No"
                , "Start-Cycle":"19"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":59
              , "name":"Load"
              , "file":"2"
              , "line":"90"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Semi-streaming"
                , "Stall-free":"No"
                , "Start-Cycle":"176"
                , "Latency":"3"
              }
            }
            , {
              "type":"inst"
              , "id":60
              , "name":"Load"
              , "file":"2"
              , "line":"91"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Semi-streaming"
                , "Stall-free":"No"
                , "Start-Cycle":"176"
                , "Latency":"3"
              }
            }
            , {
              "type":"inst"
              , "id":61
              , "name":"Load"
              , "file":"2"
              , "line":"92"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Semi-streaming"
                , "Stall-free":"No"
                , "Start-Cycle":"176"
                , "Latency":"3"
              }
            }
            , {
              "type":"inst"
              , "id":62
              , "name":"Load"
              , "file":"2"
              , "line":"96"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"235"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":63
              , "name":"Load"
              , "file":"2"
              , "line":"97"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"235"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":64
              , "name":"Load"
              , "file":"2"
              , "line":"98"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"236"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":65
              , "name":"Store"
              , "file":"2"
              , "line":"205"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"278"
                , "Latency":"2"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":66
              , "name":"Store"
              , "file":"2"
              , "line":"206"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"275"
                , "Latency":"2"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":67
              , "name":"Store"
              , "file":"2"
              , "line":"207"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"275"
                , "Latency":"2"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":68
              , "name":"loop end"
              , "file":"2"
              , "line":"79"
              , "details":
              {
                "Start-Cycle":"285"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":69
              , "name":"loop"
              , "file":""
              , "line":""
              , "loopTo":68
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
            "Latency":"286"
          }
        }
        , {
          "type":"bb"
          , "id":35
          , "name":"Block9"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":""
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"No"
          , "isPipelined":"Yes"
          , "children":[
            {
              "type":"inst"
              , "id":70
              , "name":"Load"
              , "file":"2"
              , "line":"235"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"3"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":71
              , "name":"Channel Write"
              , "file":"2"
              , "line":"235"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"110"
                , "Stall-free":"No"
                , "Start-Cycle":"13"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":73
              , "name":"Channel Write"
              , "file":"2"
              , "line":"236"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"110"
                , "Stall-free":"No"
                , "Start-Cycle":"13"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":75
              , "name":"Load"
              , "file":"2"
              , "line":"238"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"16"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":76
              , "name":"Channel Write"
              , "file":"2"
              , "line":"238"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"100"
                , "Stall-free":"No"
                , "Start-Cycle":"26"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":78
              , "name":"Channel Write"
              , "file":"2"
              , "line":"239"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"100"
                , "Stall-free":"No"
                , "Start-Cycle":"26"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":80
              , "name":"Load"
              , "file":"2"
              , "line":"241"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"29"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":81
              , "name":"Channel Write"
              , "file":"2"
              , "line":"241"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"90"
                , "Stall-free":"No"
                , "Start-Cycle":"39"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":83
              , "name":"Channel Write"
              , "file":"2"
              , "line":"242"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"90"
                , "Stall-free":"No"
                , "Start-Cycle":"39"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":85
              , "name":"Channel Write"
              , "file":"2"
              , "line":"244"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"40"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":87
              , "name":"Channel Write"
              , "file":"2"
              , "line":"245"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"40"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":89
              , "name":"Channel Write"
              , "file":"2"
              , "line":"247"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"41"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":91
              , "name":"Channel Write"
              , "file":"2"
              , "line":"248"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"41"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":93
              , "name":"Channel Write"
              , "file":"2"
              , "line":"250"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"42"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":95
              , "name":"Channel Write"
              , "file":"2"
              , "line":"251"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"42"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":97
              , "name":"loop end"
              , "file":"2"
              , "line":"234"
              , "details":
              {
                "Start-Cycle":"43"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":98
              , "name":"loop"
              , "file":""
              , "line":""
              , "loopTo":97
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
            "Latency":"44"
          }
        }
        , {
          "type":"bb"
          , "id":36
          , "name":"Block10"
          , "file":""
          , "line":"0"
          , "details":
          {
            "Latency":"2"
          }
        }
        , {
          "type":"memtype"
          , "id":101
          , "name":"Local Memory"
          , "file":""
          , "line":"0"
          , "children":[
            {
              "type":"memsys"
              , "id":102
              , "name":"genotype"
              , "file":""
              , "line":"0"
              , "replFactor":"1"
              , "banks":2
              , "pumping":2
              , "children":[
                {
                  "type":"bank"
                  , "id":103
                  , "name":"Bank 0"
                  , "file":""
                  , "line":"0"
                }
                , {
                  "type":"bank"
                  , "id":104
                  , "name":"Bank 1"
                  , "file":""
                  , "line":"0"
                }
              ]
            }
            , {
              "type":"memsys"
              , "id":105
              , "name":"loc_coords_x"
              , "file":""
              , "line":"0"
              , "replFactor":"1"
              , "banks":1
              , "pumping":2
              , "children":[
                {
                  "type":"bank"
                  , "id":106
                  , "name":"Bank 0"
                  , "file":""
                  , "line":"0"
                }
              ]
            }
            , {
              "type":"memsys"
              , "id":107
              , "name":"loc_coords_y"
              , "file":""
              , "line":"0"
              , "replFactor":"1"
              , "banks":1
              , "pumping":2
              , "children":[
                {
                  "type":"bank"
                  , "id":108
                  , "name":"Bank 0"
                  , "file":""
                  , "line":"0"
                }
              ]
            }
            , {
              "type":"memsys"
              , "id":109
              , "name":"loc_coords_z"
              , "file":""
              , "line":"0"
              , "replFactor":"1"
              , "banks":1
              , "pumping":2
              , "children":[
                {
                  "type":"bank"
                  , "id":110
                  , "name":"Bank 0"
                  , "file":""
                  , "line":"0"
                }
              ]
            }
          ]
        }
      ]
    }
    , {
      "type":"kernel"
      , "id":178
      , "name":"Krnl_InterE"
      , "file":""
      , "line":"0"
      , "children":[
        {
          "type":"bb"
          , "id":112
          , "name":"Block11.wii_blk"
          , "file":""
          , "line":"0"
          , "children":[
            {
              "type":"inst"
              , "id":119
              , "name":"Load"
              , "file":"3"
              , "line":"47"
              , "details":
              {
                "Width":"128 bits"
                , "Type":"Simple"
                , "Stall-free":"No"
                , "Start-Cycle":"2"
                , "Latency":"1"
                , "Additional Info":" This operation is work-item invariant -- it performs the same operation for all threads in the kernel."
              }
            }
            , {
              "type":"inst"
              , "id":120
              , "name":"end"
              , "file":"0"
              , "line":"0"
              , "details":
              {
                "Start-Cycle":"15"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":121
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
            "Latency":"16"
          }
        }
        , {
          "type":"bb"
          , "id":113
          , "name":"Block12"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":"Entry to loop. "
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"Yes"
          , "isPipelined":"No"
          , "loopTo":175
          , "details":
          {
            "Latency":"2"
          }
        }
        , {
          "type":"bb"
          , "id":114
          , "name":"Block13"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":""
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"No"
          , "isPipelined":"Yes"
          , "children":[
            {
              "type":"inst"
              , "id":122
              , "name":"Channel Read"
              , "file":"3"
              , "line":"62"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"110"
                , "Stall-free":"No"
                , "Start-Cycle":"10"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":123
              , "name":"Store"
              , "file":"3"
              , "line":"62"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"11"
                , "Latency":"2"
              }
            }
            , {
              "type":"inst"
              , "id":124
              , "name":"Channel Read"
              , "file":"3"
              , "line":"64"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"100"
                , "Stall-free":"No"
                , "Start-Cycle":"13"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":125
              , "name":"Store"
              , "file":"3"
              , "line":"64"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"14"
                , "Latency":"2"
              }
            }
            , {
              "type":"inst"
              , "id":126
              , "name":"Channel Read"
              , "file":"3"
              , "line":"66"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"90"
                , "Stall-free":"No"
                , "Start-Cycle":"16"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":127
              , "name":"Store"
              , "file":"3"
              , "line":"66"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"17"
                , "Latency":"2"
              }
            }
            , {
              "type":"inst"
              , "id":128
              , "name":"Channel Read"
              , "file":"3"
              , "line":"68"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"19"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":129
              , "name":"Channel Read"
              , "file":"3"
              , "line":"70"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"20"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":130
              , "name":"Channel Read"
              , "file":"3"
              , "line":"72"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"21"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":131
              , "name":"loop end"
              , "file":"3"
              , "line":"61"
              , "details":
              {
                "Start-Cycle":"22"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":132
              , "name":"loop"
              , "file":""
              , "line":""
              , "loopTo":131
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
            "Latency":"23"
          }
        }
        , {
          "type":"bb"
          , "id":115
          , "name":"Block14"
          , "file":""
          , "line":"0"
          , "children":[
            {
              "type":"inst"
              , "id":133
              , "name":"Store"
              , "file":"3"
              , "line":"77"
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
              , "id":134
              , "name":"end"
              , "file":"0"
              , "line":"0"
              , "details":
              {
                "Start-Cycle":"8"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":135
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
        , {
          "type":"bb"
          , "id":116
          , "name":"Block15"
          , "file":""
          , "line":"0"
          , "II":13
          , "LoopInfo":"Loop is pipelined with II of 13. See Optimization Report for more information."
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"No"
          , "isPipelined":"Yes"
          , "children":[
            {
              "type":"inst"
              , "id":136
              , "name":"Load"
              , "file":"3"
              , "line":"89"
              , "details":
              {
                "Width":"8 bits"
                , "Type":"Semi-streaming"
                , "Stall-free":"No"
                , "Start-Cycle":"14"
                , "Latency":"3"
              }
            }
            , {
              "type":"inst"
              , "id":137
              , "name":"Load"
              , "file":"3"
              , "line":"93"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Semi-streaming"
                , "Stall-free":"No"
                , "Start-Cycle":"201"
                , "Latency":"3"
              }
            }
            , {
              "type":"inst"
              , "id":138
              , "name":"Load"
              , "file":"3"
              , "line":"90"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"20"
                , "Latency":"4"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":139
              , "name":"Load"
              , "file":"3"
              , "line":"91"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"19"
                , "Latency":"4"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":140
              , "name":"Load"
              , "file":"3"
              , "line":"92"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"20"
                , "Latency":"4"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":141
              , "name":"Load"
              , "file":"3"
              , "line":"153"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":142
              , "name":"Load"
              , "file":"3"
              , "line":"154"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":143
              , "name":"Load"
              , "file":"3"
              , "line":"155"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":144
              , "name":"Load"
              , "file":"3"
              , "line":"156"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":145
              , "name":"Load"
              , "file":"3"
              , "line":"157"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":146
              , "name":"Load"
              , "file":"3"
              , "line":"158"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":147
              , "name":"Load"
              , "file":"3"
              , "line":"159"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":148
              , "name":"Load"
              , "file":"3"
              , "line":"160"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":149
              , "name":"Load"
              , "file":"3"
              , "line":"183"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":150
              , "name":"Load"
              , "file":"3"
              , "line":"184"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":151
              , "name":"Load"
              , "file":"3"
              , "line":"185"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":152
              , "name":"Load"
              , "file":"3"
              , "line":"186"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":153
              , "name":"Load"
              , "file":"3"
              , "line":"187"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":154
              , "name":"Load"
              , "file":"3"
              , "line":"188"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":155
              , "name":"Load"
              , "file":"3"
              , "line":"189"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":156
              , "name":"Load"
              , "file":"3"
              , "line":"190"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":157
              , "name":"Load"
              , "file":"3"
              , "line":"213"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":158
              , "name":"Load"
              , "file":"3"
              , "line":"214"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":159
              , "name":"Load"
              , "file":"3"
              , "line":"215"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":160
              , "name":"Load"
              , "file":"3"
              , "line":"216"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":161
              , "name":"Load"
              , "file":"3"
              , "line":"217"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":162
              , "name":"Load"
              , "file":"3"
              , "line":"218"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":163
              , "name":"Load"
              , "file":"3"
              , "line":"219"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":164
              , "name":"Load"
              , "file":"3"
              , "line":"220"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"44"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":165
              , "name":"loop end"
              , "file":"3"
              , "line":"87"
              , "details":
              {
                "Start-Cycle":"273"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":166
              , "name":"loop"
              , "file":""
              , "line":""
              , "loopTo":165
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
            "Latency":"274"
          }
        }
        , {
          "type":"bb"
          , "id":117
          , "name":"Block16"
          , "file":""
          , "line":"0"
          , "details":
          {
            "Latency":"2"
          }
        }
        , {
          "type":"bb"
          , "id":118
          , "name":"Block17"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":"Exit which branches back to loop. "
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"Yes"
          , "isPipelined":"No"
          , "children":[
            {
              "type":"inst"
              , "id":167
              , "name":"Channel Write"
              , "file":"3"
              , "line":"246"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"393"
                , "Stall-free":"No"
                , "Start-Cycle":"1"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":169
              , "name":"Channel Write"
              , "file":"3"
              , "line":"248"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"392"
                , "Stall-free":"No"
                , "Start-Cycle":"2"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":171
              , "name":"Channel Write"
              , "file":"3"
              , "line":"250"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"391"
                , "Stall-free":"No"
                , "Start-Cycle":"3"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":173
              , "name":"Channel Write"
              , "file":"3"
              , "line":"252"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"391"
                , "Stall-free":"No"
                , "Start-Cycle":"4"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":175
              , "name":"end"
              , "file":"3"
              , "line":"55"
              , "details":
              {
                "Start-Cycle":"5"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":176
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
            "Latency":"6"
          }
        }
        , {
          "type":"memtype"
          , "id":179
          , "name":"Local Memory"
          , "file":""
          , "line":"0"
          , "children":[
            {
              "type":"memsys"
              , "id":180
              , "name":"loc_coords_x"
              , "file":""
              , "line":"0"
              , "replFactor":"1"
              , "banks":1
              , "pumping":1
              , "children":[
                {
                  "type":"bank"
                  , "id":181
                  , "name":"Bank 0"
                  , "file":""
                  , "line":"0"
                }
              ]
            }
            , {
              "type":"memsys"
              , "id":182
              , "name":"loc_coords_y"
              , "file":""
              , "line":"0"
              , "replFactor":"1"
              , "banks":1
              , "pumping":1
              , "children":[
                {
                  "type":"bank"
                  , "id":183
                  , "name":"Bank 0"
                  , "file":""
                  , "line":"0"
                }
              ]
            }
            , {
              "type":"memsys"
              , "id":184
              , "name":"loc_coords_z"
              , "file":""
              , "line":"0"
              , "replFactor":"1"
              , "banks":1
              , "pumping":1
              , "children":[
                {
                  "type":"bank"
                  , "id":185
                  , "name":"Bank 0"
                  , "file":""
                  , "line":"0"
                }
              ]
            }
          ]
        }
      ]
    }
    , {
      "type":"kernel"
      , "id":243
      , "name":"Krnl_IntraE"
      , "file":""
      , "line":"0"
      , "children":[
        {
          "type":"bb"
          , "id":187
          , "name":"Block18.wii_blk"
          , "file":""
          , "line":"0"
          , "children":[
            {
              "type":"inst"
              , "id":194
              , "name":"Load"
              , "file":"4"
              , "line":"40"
              , "details":
              {
                "Width":"256 bits"
                , "Type":"Simple"
                , "Stall-free":"No"
                , "Start-Cycle":"2"
                , "Latency":"1"
                , "Additional Info":" This operation is work-item invariant -- it performs the same operation for all threads in the kernel."
              }
            }
            , {
              "type":"inst"
              , "id":195
              , "name":"Load"
              , "file":"4"
              , "line":"112"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Simple"
                , "Stall-free":"No"
                , "Start-Cycle":"5"
                , "Latency":"1"
                , "Additional Info":" This operation is work-item invariant -- it performs the same operation for all threads in the kernel."
              }
            }
            , {
              "type":"inst"
              , "id":196
              , "name":"end"
              , "file":"0"
              , "line":"0"
              , "details":
              {
                "Start-Cycle":"6"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":197
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
            "Latency":"7"
          }
        }
        , {
          "type":"bb"
          , "id":188
          , "name":"Block19"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":"Entry to loop. "
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"Yes"
          , "isPipelined":"No"
          , "loopTo":240
          , "details":
          {
            "Latency":"2"
          }
        }
        , {
          "type":"bb"
          , "id":189
          , "name":"Block20"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":""
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"No"
          , "isPipelined":"Yes"
          , "children":[
            {
              "type":"inst"
              , "id":198
              , "name":"Channel Read"
              , "file":"4"
              , "line":"41"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"110"
                , "Stall-free":"No"
                , "Start-Cycle":"10"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":199
              , "name":"Store"
              , "file":"4"
              , "line":"41"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"11"
                , "Latency":"2"
              }
            }
            , {
              "type":"inst"
              , "id":200
              , "name":"Channel Read"
              , "file":"4"
              , "line":"43"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"100"
                , "Stall-free":"No"
                , "Start-Cycle":"13"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":201
              , "name":"Store"
              , "file":"4"
              , "line":"43"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"14"
                , "Latency":"2"
              }
            }
            , {
              "type":"inst"
              , "id":202
              , "name":"Channel Read"
              , "file":"4"
              , "line":"45"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"90"
                , "Stall-free":"No"
                , "Start-Cycle":"16"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":203
              , "name":"Store"
              , "file":"4"
              , "line":"45"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"17"
                , "Latency":"2"
              }
            }
            , {
              "type":"inst"
              , "id":204
              , "name":"Channel Read"
              , "file":"4"
              , "line":"47"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"19"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":205
              , "name":"Channel Read"
              , "file":"4"
              , "line":"49"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"20"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":206
              , "name":"Channel Read"
              , "file":"4"
              , "line":"51"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"21"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":207
              , "name":"loop end"
              , "file":"4"
              , "line":"40"
              , "details":
              {
                "Start-Cycle":"22"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":208
              , "name":"loop"
              , "file":""
              , "line":""
              , "loopTo":207
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
            "Latency":"23"
          }
        }
        , {
          "type":"bb"
          , "id":190
          , "name":"Block21"
          , "file":""
          , "line":"0"
          , "children":[
            {
              "type":"inst"
              , "id":209
              , "name":"Store"
              , "file":"4"
              , "line":"56"
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
              , "id":210
              , "name":"end"
              , "file":"0"
              , "line":"0"
              , "details":
              {
                "Start-Cycle":"8"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":211
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
        , {
          "type":"bb"
          , "id":191
          , "name":"Block22"
          , "file":""
          , "line":"0"
          , "II":17
          , "LoopInfo":"Loop is pipelined with II of 17. See Optimization Report for more information."
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"No"
          , "isPipelined":"Yes"
          , "children":[
            {
              "type":"inst"
              , "id":212
              , "name":"Load"
              , "file":"4"
              , "line":"67"
              , "details":
              {
                "Width":"16 bits"
                , "Type":"Burst-non-aligned"
                , "Stall-free":"No"
                , "Start-Cycle":"18"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":213
              , "name":"Load"
              , "file":"4"
              , "line":"70"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"180"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":214
              , "name":"Load"
              , "file":"4"
              , "line":"70"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"180"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":215
              , "name":"Load"
              , "file":"4"
              , "line":"71"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"180"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":216
              , "name":"Load"
              , "file":"4"
              , "line":"71"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"180"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":217
              , "name":"Load"
              , "file":"4"
              , "line":"72"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"187"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":218
              , "name":"Load"
              , "file":"4"
              , "line":"72"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Pipelined"
                , "Stall-free":"Yes"
                , "Start-Cycle":"187"
                , "Latency":"5"
                , "Additional Info":" Part of a stall-free cluster."
              }
            }
            , {
              "type":"inst"
              , "id":219
              , "name":"Load"
              , "file":"4"
              , "line":"97"
              , "details":
              {
                "Width":"8 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"284"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":220
              , "name":"Load"
              , "file":"4"
              , "line":"103"
              , "details":
              {
                "Width":"8 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"449"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":221
              , "name":"Load"
              , "file":"4"
              , "line":"98"
              , "details":
              {
                "Width":"8 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"284"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":222
              , "name":"Load"
              , "file":"4"
              , "line":"109"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"284"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":223
              , "name":"Load"
              , "file":"4"
              , "line":"109"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"284"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":224
              , "name":"Load"
              , "file":"4"
              , "line":"101"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"449"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":225
              , "name":"Load"
              , "file":"4"
              , "line":"104"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"449"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":226
              , "name":"Load"
              , "file":"4"
              , "line":"112"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"449"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":227
              , "name":"Load"
              , "file":"4"
              , "line":"114"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"449"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":228
              , "name":"Load"
              , "file":"4"
              , "line":"113"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"449"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":229
              , "name":"Load"
              , "file":"4"
              , "line":"113"
              , "details":
              {
                "Width":"32 bits"
                , "Type":"Burst-coalesced"
                , "Stall-free":"No"
                , "Start-Cycle":"449"
                , "Latency":"160"
              }
            }
            , {
              "type":"inst"
              , "id":230
              , "name":"loop end"
              , "file":"4"
              , "line":"65"
              , "details":
              {
                "Start-Cycle":"662"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":231
              , "name":"loop"
              , "file":""
              , "line":""
              , "loopTo":230
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
            "Latency":"663"
          }
        }
        , {
          "type":"bb"
          , "id":192
          , "name":"Block23"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":"Exit which branches back to loop. "
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"Yes"
          , "isPipelined":"No"
          , "children":[
            {
              "type":"inst"
              , "id":232
              , "name":"Channel Write"
              , "file":"4"
              , "line":"124"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"1"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":234
              , "name":"Channel Write"
              , "file":"4"
              , "line":"126"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"0"
                , "Stall-free":"No"
                , "Start-Cycle":"2"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":236
              , "name":"Channel Write"
              , "file":"4"
              , "line":"128"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"0"
                , "Stall-free":"No"
                , "Start-Cycle":"3"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":238
              , "name":"Channel Write"
              , "file":"4"
              , "line":"130"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"0"
                , "Stall-free":"No"
                , "Start-Cycle":"4"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":240
              , "name":"end"
              , "file":"4"
              , "line":"34"
              , "details":
              {
                "Start-Cycle":"5"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":241
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
            "Latency":"6"
          }
        }
        , {
          "type":"bb"
          , "id":193
          , "name":"Block24"
          , "file":""
          , "line":"0"
          , "details":
          {
            "Latency":"2"
          }
        }
        , {
          "type":"memtype"
          , "id":244
          , "name":"Local Memory"
          , "file":""
          , "line":"0"
          , "children":[
            {
              "type":"memsys"
              , "id":245
              , "name":"loc_coords_x"
              , "file":""
              , "line":"0"
              , "replFactor":"1"
              , "banks":1
              , "pumping":2
              , "children":[
                {
                  "type":"bank"
                  , "id":246
                  , "name":"Bank 0"
                  , "file":""
                  , "line":"0"
                }
              ]
            }
            , {
              "type":"memsys"
              , "id":247
              , "name":"loc_coords_y"
              , "file":""
              , "line":"0"
              , "replFactor":"1"
              , "banks":1
              , "pumping":2
              , "children":[
                {
                  "type":"bank"
                  , "id":248
                  , "name":"Bank 0"
                  , "file":""
                  , "line":"0"
                }
              ]
            }
            , {
              "type":"memsys"
              , "id":249
              , "name":"loc_coords_z"
              , "file":""
              , "line":"0"
              , "replFactor":"1"
              , "banks":1
              , "pumping":2
              , "children":[
                {
                  "type":"bank"
                  , "id":250
                  , "name":"Bank 0"
                  , "file":""
                  , "line":"0"
                }
              ]
            }
          ]
        }
      ]
    }
    , {
      "type":"kernel"
      , "id":270
      , "name":"Krnl_Store"
      , "file":""
      , "line":"0"
      , "children":[
        {
          "type":"bb"
          , "id":252
          , "name":"Block25"
          , "file":""
          , "line":"0"
          , "details":
          {
            "Latency":"2"
          }
        }
        , {
          "type":"bb"
          , "id":253
          , "name":"Block26"
          , "file":""
          , "line":"0"
          , "II":1
          , "LoopInfo":""
          , "hasFmaxBottlenecks":"No"
          , "hasSubloops":"No"
          , "isPipelined":"Yes"
          , "children":[
            {
              "type":"inst"
              , "id":255
              , "name":"Channel Read"
              , "file":"5"
              , "line":"32"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"393"
                , "Stall-free":"No"
                , "Start-Cycle":"2"
                , "Latency":"0"
              }
            }
            , {
              "type":"inst"
              , "id":256
              , "name":"Channel Read"
              , "file":"5"
              , "line":"33"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"1"
                , "Stall-free":"No"
                , "Start-Cycle":"2"
                , "Latency":"0"
              }
            }
            , {
              "type":"inst"
              , "id":257
              , "name":"Channel Read"
              , "file":"5"
              , "line":"35"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"392"
                , "Stall-free":"No"
                , "Start-Cycle":"2"
                , "Latency":"0"
              }
            }
            , {
              "type":"inst"
              , "id":258
              , "name":"Channel Read"
              , "file":"5"
              , "line":"36"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"0"
                , "Stall-free":"No"
                , "Start-Cycle":"2"
                , "Latency":"0"
              }
            }
            , {
              "type":"inst"
              , "id":259
              , "name":"Channel Read"
              , "file":"5"
              , "line":"38"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"391"
                , "Stall-free":"No"
                , "Start-Cycle":"2"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":260
              , "name":"Channel Read"
              , "file":"5"
              , "line":"39"
              , "details":
              {
                "Width":"8 bits"
                , "Depth":"0"
                , "Stall-free":"No"
                , "Start-Cycle":"2"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":261
              , "name":"Channel Read"
              , "file":"5"
              , "line":"41"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"391"
                , "Stall-free":"No"
                , "Start-Cycle":"3"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":262
              , "name":"Channel Read"
              , "file":"5"
              , "line":"42"
              , "details":
              {
                "Width":"32 bits"
                , "Depth":"0"
                , "Stall-free":"No"
                , "Start-Cycle":"3"
                , "Latency":"1"
              }
            }
            , {
              "type":"inst"
              , "id":263
              , "name":"Store"
              , "file":"5"
              , "line":"46"
              , "details":
              {
                "Width":"256 bits"
                , "Type":"Burst-non-aligned"
                , "Stall-free":"No"
                , "Start-Cycle":"6"
                , "Latency":"4"
              }
            }
            , {
              "type":"inst"
              , "id":264
              , "name":"Store"
              , "file":"5"
              , "line":"49"
              , "details":
              {
                "Width":"256 bits"
                , "Type":"Burst-non-aligned"
                , "Stall-free":"No"
                , "Start-Cycle":"6"
                , "Latency":"4"
              }
            }
            , {
              "type":"inst"
              , "id":265
              , "name":"Store"
              , "file":"5"
              , "line":"55"
              , "details":
              {
                "Width":"256 bits"
                , "Type":"Burst-non-aligned"
                , "Stall-free":"No"
                , "Start-Cycle":"6"
                , "Latency":"4"
              }
            }
            , {
              "type":"inst"
              , "id":266
              , "name":"Store"
              , "file":"5"
              , "line":"52"
              , "details":
              {
                "Width":"256 bits"
                , "Type":"Burst-non-aligned"
                , "Stall-free":"No"
                , "Start-Cycle":"7"
                , "Latency":"4"
              }
            }
            , {
              "type":"inst"
              , "id":267
              , "name":"loop end"
              , "file":"5"
              , "line":"30"
              , "details":
              {
                "Start-Cycle":"11"
                , "Latency":"1"
                , "Additional Info":"Exit from a basic block. Control flow branches at this node to one or more merge nodes. There is no control branching between merge and branch node for the same basic block."
              }
            }
            , {
              "type":"inst"
              , "id":268
              , "name":"loop"
              , "file":""
              , "line":""
              , "loopTo":267
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
            "Latency":"12"
          }
        }
        , {
          "type":"bb"
          , "id":254
          , "name":"Block27"
          , "file":""
          , "line":"0"
          , "details":
          {
            "Latency":"2"
          }
        }
      ]
    }
    , {
      "type":"memtype"
      , "id":25
      , "name":"Global Memory"
      , "file":""
      , "line":"0"
      , "children":[
        {
          "type":"memsys"
          , "id":26
          , "name":"DDR"
          , "file":""
          , "line":"0"
          , "replFactor":"0"
          , "banks":1
          , "pumping":0
          , "children":[
            {
              "type":"bank"
              , "id":27
              , "name":"Bank 0"
              , "file":""
              , "line":"0"
            }
          ]
        }
      ]
    }
    , {
      "type":"channel"
      , "id":86
      , "name":"chan_Conf2Intere_active"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"8 bits"
        , "Depth":"1"
      }
    }
    , {
      "type":"channel"
      , "id":94
      , "name":"chan_Conf2Intere_cnt"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"1"
      }
    }
    , {
      "type":"channel"
      , "id":90
      , "name":"chan_Conf2Intere_mode"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"8 bits"
        , "Depth":"1"
      }
    }
    , {
      "type":"channel"
      , "id":72
      , "name":"chan_Conf2Intere_x"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"110"
      }
    }
    , {
      "type":"channel"
      , "id":77
      , "name":"chan_Conf2Intere_y"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"100"
      }
    }
    , {
      "type":"channel"
      , "id":82
      , "name":"chan_Conf2Intere_z"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"90"
      }
    }
    , {
      "type":"channel"
      , "id":88
      , "name":"chan_Conf2Intrae_active"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"8 bits"
        , "Depth":"1"
      }
    }
    , {
      "type":"channel"
      , "id":96
      , "name":"chan_Conf2Intrae_cnt"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"1"
      }
    }
    , {
      "type":"channel"
      , "id":92
      , "name":"chan_Conf2Intrae_mode"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"8 bits"
        , "Depth":"1"
      }
    }
    , {
      "type":"channel"
      , "id":74
      , "name":"chan_Conf2Intrae_x"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"110"
      }
    }
    , {
      "type":"channel"
      , "id":79
      , "name":"chan_Conf2Intrae_y"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"100"
      }
    }
    , {
      "type":"channel"
      , "id":84
      , "name":"chan_Conf2Intrae_z"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"90"
      }
    }
    , {
      "type":"channel"
      , "id":14
      , "name":"chan_GA2Conf_active"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"8 bits"
        , "Depth":"48"
      }
    }
    , {
      "type":"channel"
      , "id":18
      , "name":"chan_GA2Conf_cnt"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"0"
      }
    }
    , {
      "type":"channel"
      , "id":10
      , "name":"chan_GA2Conf_genotype"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"39"
      }
    }
    , {
      "type":"channel"
      , "id":16
      , "name":"chan_GA2Conf_mode"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"8 bits"
        , "Depth":"0"
      }
    }
    , {
      "type":"channel"
      , "id":170
      , "name":"chan_Intere2Store_active"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"8 bits"
        , "Depth":"392"
      }
    }
    , {
      "type":"channel"
      , "id":174
      , "name":"chan_Intere2Store_cnt"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"391"
      }
    }
    , {
      "type":"channel"
      , "id":168
      , "name":"chan_Intere2Store_intere"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"393"
      }
    }
    , {
      "type":"channel"
      , "id":172
      , "name":"chan_Intere2Store_mode"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"8 bits"
        , "Depth":"391"
      }
    }
    , {
      "type":"channel"
      , "id":235
      , "name":"chan_Intrae2Store_active"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"8 bits"
        , "Depth":"0"
      }
    }
    , {
      "type":"channel"
      , "id":239
      , "name":"chan_Intrae2Store_cnt"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"0"
      }
    }
    , {
      "type":"channel"
      , "id":233
      , "name":"chan_Intrae2Store_intrae"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"32 bits"
        , "Depth":"1"
      }
    }
    , {
      "type":"channel"
      , "id":237
      , "name":"chan_Intrae2Store_mode"
      , "file":""
      , "line":"0"
      , "details":
      {
        "Width":"8 bits"
        , "Depth":"0"
      }
    }
  ]
  ,
  "links":
  [
    {
      "from":9
      , "to":10
    }
    ,
    {
      "from":13
      , "to":14
    }
    ,
    {
      "from":15
      , "to":16
    }
    ,
    {
      "from":17
      , "to":18
    }
    ,
    {
      "from":22
      , "to":15
    }
    ,
    {
      "from":8
      , "to":6
    }
    ,
    {
      "from":22
      , "to":20
    }
    ,
    {
      "from":22
      , "to":13
    }
    ,
    {
      "from":22
      , "to":17
    }
    ,
    {
      "from":12
      , "to":9
    }
    ,
    {
      "from":22
      , "to":19
    }
    ,
    {
      "from":11
      , "to":22
    }
    ,
    {
      "from":11
      , "to":12
    }
    ,
    {
      "from":7
      , "to":12
    }
    ,
    {
      "from":6
      , "to":7
    }
    ,
    {
      "from":17
      , "to":21
    }
    ,
    {
      "from":15
      , "to":21
    }
    ,
    {
      "from":13
      , "to":21
    }
    ,
    {
      "from":20
      , "to":21
    }
    ,
    {
      "from":19
      , "to":21
    }
    ,
    {
      "from":9
      , "to":11
    }
    ,
    {
      "from":6
      , "to":27
    }
    ,
    {
      "from":20
      , "to":27
    }
    ,
    {
      "from":19
      , "to":27
    }
    ,
    {
      "from":10
      , "to":41
    }
    ,
    {
      "from":14
      , "to":45
    }
    ,
    {
      "from":16
      , "to":46
    }
    ,
    {
      "from":18
      , "to":47
    }
    ,
    {
      "from":71
      , "to":72
    }
    ,
    {
      "from":73
      , "to":74
    }
    ,
    {
      "from":76
      , "to":77
    }
    ,
    {
      "from":78
      , "to":79
    }
    ,
    {
      "from":81
      , "to":82
    }
    ,
    {
      "from":83
      , "to":84
    }
    ,
    {
      "from":85
      , "to":86
    }
    ,
    {
      "from":87
      , "to":88
    }
    ,
    {
      "from":89
      , "to":90
    }
    ,
    {
      "from":91
      , "to":92
    }
    ,
    {
      "from":93
      , "to":94
    }
    ,
    {
      "from":95
      , "to":96
    }
    ,
    {
      "from":104
      , "to":48
    }
    ,
    {
      "from":103
      , "to":49
    }
    ,
    {
      "from":103
      , "to":50
    }
    ,
    {
      "from":104
      , "to":51
    }
    ,
    {
      "from":103
      , "to":56
    }
    ,
    {
      "from":104
      , "to":56
    }
    ,
    {
      "from":42
      , "to":103
    }
    ,
    {
      "from":42
      , "to":104
    }
    ,
    {
      "from":106
      , "to":62
    }
    ,
    {
      "from":106
      , "to":70
    }
    ,
    {
      "from":65
      , "to":106
    }
    ,
    {
      "from":108
      , "to":63
    }
    ,
    {
      "from":108
      , "to":75
    }
    ,
    {
      "from":66
      , "to":108
    }
    ,
    {
      "from":110
      , "to":64
    }
    ,
    {
      "from":110
      , "to":80
    }
    ,
    {
      "from":67
      , "to":110
    }
    ,
    {
      "from":69
      , "to":55
    }
    ,
    {
      "from":40
      , "to":38
    }
    ,
    {
      "from":87
      , "to":89
    }
    ,
    {
      "from":85
      , "to":89
    }
    ,
    {
      "from":70
      , "to":73
    }
    ,
    {
      "from":98
      , "to":70
    }
    ,
    {
      "from":55
      , "to":57
    }
    ,
    {
      "from":56
      , "to":57
    }
    ,
    {
      "from":41
      , "to":42
    }
    ,
    {
      "from":44
      , "to":41
    }
    ,
    {
      "from":81
      , "to":85
    }
    ,
    {
      "from":83
      , "to":85
    }
    ,
    {
      "from":54
      , "to":49
    }
    ,
    {
      "from":55
      , "to":66
    }
    ,
    {
      "from":56
      , "to":66
    }
    ,
    {
      "from":61
      , "to":66
    }
    ,
    {
      "from":60
      , "to":66
    }
    ,
    {
      "from":59
      , "to":66
    }
    ,
    {
      "from":57
      , "to":66
    }
    ,
    {
      "from":58
      , "to":66
    }
    ,
    {
      "from":62
      , "to":66
    }
    ,
    {
      "from":63
      , "to":66
    }
    ,
    {
      "from":64
      , "to":66
    }
    ,
    {
      "from":55
      , "to":67
    }
    ,
    {
      "from":56
      , "to":67
    }
    ,
    {
      "from":61
      , "to":67
    }
    ,
    {
      "from":60
      , "to":67
    }
    ,
    {
      "from":59
      , "to":67
    }
    ,
    {
      "from":57
      , "to":67
    }
    ,
    {
      "from":58
      , "to":67
    }
    ,
    {
      "from":62
      , "to":67
    }
    ,
    {
      "from":63
      , "to":67
    }
    ,
    {
      "from":64
      , "to":67
    }
    ,
    {
      "from":55
      , "to":60
    }
    ,
    {
      "from":89
      , "to":93
    }
    ,
    {
      "from":91
      , "to":93
    }
    ,
    {
      "from":54
      , "to":47
    }
    ,
    {
      "from":55
      , "to":64
    }
    ,
    {
      "from":56
      , "to":64
    }
    ,
    {
      "from":61
      , "to":64
    }
    ,
    {
      "from":60
      , "to":64
    }
    ,
    {
      "from":59
      , "to":64
    }
    ,
    {
      "from":57
      , "to":64
    }
    ,
    {
      "from":58
      , "to":64
    }
    ,
    {
      "from":54
      , "to":45
    }
    ,
    {
      "from":55
      , "to":62
    }
    ,
    {
      "from":56
      , "to":62
    }
    ,
    {
      "from":61
      , "to":62
    }
    ,
    {
      "from":60
      , "to":62
    }
    ,
    {
      "from":59
      , "to":62
    }
    ,
    {
      "from":57
      , "to":62
    }
    ,
    {
      "from":58
      , "to":62
    }
    ,
    {
      "from":75
      , "to":76
    }
    ,
    {
      "from":70
      , "to":76
    }
    ,
    {
      "from":71
      , "to":76
    }
    ,
    {
      "from":73
      , "to":76
    }
    ,
    {
      "from":81
      , "to":87
    }
    ,
    {
      "from":83
      , "to":87
    }
    ,
    {
      "from":54
      , "to":51
    }
    ,
    {
      "from":70
      , "to":71
    }
    ,
    {
      "from":55
      , "to":63
    }
    ,
    {
      "from":56
      , "to":63
    }
    ,
    {
      "from":61
      , "to":63
    }
    ,
    {
      "from":60
      , "to":63
    }
    ,
    {
      "from":59
      , "to":63
    }
    ,
    {
      "from":57
      , "to":63
    }
    ,
    {
      "from":58
      , "to":63
    }
    ,
    {
      "from":70
      , "to":75
    }
    ,
    {
      "from":71
      , "to":75
    }
    ,
    {
      "from":73
      , "to":75
    }
    ,
    {
      "from":40
      , "to":37
    }
    ,
    {
      "from":45
      , "to":52
    }
    ,
    {
      "from":54
      , "to":50
    }
    ,
    {
      "from":55
      , "to":59
    }
    ,
    {
      "from":55
      , "to":58
    }
    ,
    {
      "from":56
      , "to":58
    }
    ,
    {
      "from":75
      , "to":78
    }
    ,
    {
      "from":70
      , "to":78
    }
    ,
    {
      "from":71
      , "to":78
    }
    ,
    {
      "from":73
      , "to":78
    }
    ,
    {
      "from":80
      , "to":81
    }
    ,
    {
      "from":76
      , "to":81
    }
    ,
    {
      "from":78
      , "to":81
    }
    ,
    {
      "from":70
      , "to":81
    }
    ,
    {
      "from":54
      , "to":48
    }
    ,
    {
      "from":54
      , "to":46
    }
    ,
    {
      "from":76
      , "to":80
    }
    ,
    {
      "from":78
      , "to":80
    }
    ,
    {
      "from":70
      , "to":80
    }
    ,
    {
      "from":55
      , "to":56
    }
    ,
    {
      "from":55
      , "to":61
    }
    ,
    {
      "from":89
      , "to":95
    }
    ,
    {
      "from":91
      , "to":95
    }
    ,
    {
      "from":55
      , "to":65
    }
    ,
    {
      "from":56
      , "to":65
    }
    ,
    {
      "from":61
      , "to":65
    }
    ,
    {
      "from":60
      , "to":65
    }
    ,
    {
      "from":59
      , "to":65
    }
    ,
    {
      "from":57
      , "to":65
    }
    ,
    {
      "from":58
      , "to":65
    }
    ,
    {
      "from":62
      , "to":65
    }
    ,
    {
      "from":63
      , "to":65
    }
    ,
    {
      "from":64
      , "to":65
    }
    ,
    {
      "from":87
      , "to":91
    }
    ,
    {
      "from":85
      , "to":91
    }
    ,
    {
      "from":80
      , "to":83
    }
    ,
    {
      "from":76
      , "to":83
    }
    ,
    {
      "from":78
      , "to":83
    }
    ,
    {
      "from":70
      , "to":83
    }
    ,
    {
      "from":70
      , "to":97
    }
    ,
    {
      "from":95
      , "to":97
    }
    ,
    {
      "from":93
      , "to":97
    }
    ,
    {
      "from":68
      , "to":69
    }
    ,
    {
      "from":53
      , "to":69
    }
    ,
    {
      "from":50
      , "to":53
    }
    ,
    {
      "from":49
      , "to":53
    }
    ,
    {
      "from":48
      , "to":53
    }
    ,
    {
      "from":45
      , "to":53
    }
    ,
    {
      "from":52
      , "to":53
    }
    ,
    {
      "from":51
      , "to":53
    }
    ,
    {
      "from":46
      , "to":53
    }
    ,
    {
      "from":47
      , "to":53
    }
    ,
    {
      "from":43
      , "to":44
    }
    ,
    {
      "from":31
      , "to":44
    }
    ,
    {
      "from":30
      , "to":31
    }
    ,
    {
      "from":39
      , "to":31
    }
    ,
    {
      "from":43
      , "to":54
    }
    ,
    {
      "from":97
      , "to":98
    }
    ,
    {
      "from":68
      , "to":98
    }
    ,
    {
      "from":37
      , "to":39
    }
    ,
    {
      "from":38
      , "to":39
    }
    ,
    {
      "from":55
      , "to":68
    }
    ,
    {
      "from":56
      , "to":68
    }
    ,
    {
      "from":61
      , "to":68
    }
    ,
    {
      "from":60
      , "to":68
    }
    ,
    {
      "from":59
      , "to":68
    }
    ,
    {
      "from":57
      , "to":68
    }
    ,
    {
      "from":58
      , "to":68
    }
    ,
    {
      "from":97
      , "to":30
    }
    ,
    {
      "from":42
      , "to":43
    }
    ,
    {
      "from":30
      , "to":36
    }
    ,
    {
      "from":27
      , "to":55
    }
    ,
    {
      "from":27
      , "to":38
    }
    ,
    {
      "from":27
      , "to":57
    }
    ,
    {
      "from":27
      , "to":60
    }
    ,
    {
      "from":27
      , "to":37
    }
    ,
    {
      "from":52
      , "to":27
    }
    ,
    {
      "from":27
      , "to":59
    }
    ,
    {
      "from":27
      , "to":58
    }
    ,
    {
      "from":27
      , "to":61
    }
    ,
    {
      "from":72
      , "to":122
    }
    ,
    {
      "from":77
      , "to":124
    }
    ,
    {
      "from":82
      , "to":126
    }
    ,
    {
      "from":86
      , "to":128
    }
    ,
    {
      "from":90
      , "to":129
    }
    ,
    {
      "from":94
      , "to":130
    }
    ,
    {
      "from":167
      , "to":168
    }
    ,
    {
      "from":169
      , "to":170
    }
    ,
    {
      "from":171
      , "to":172
    }
    ,
    {
      "from":173
      , "to":174
    }
    ,
    {
      "from":181
      , "to":138
    }
    ,
    {
      "from":123
      , "to":181
    }
    ,
    {
      "from":183
      , "to":139
    }
    ,
    {
      "from":125
      , "to":183
    }
    ,
    {
      "from":185
      , "to":140
    }
    ,
    {
      "from":127
      , "to":185
    }
    ,
    {
      "from":138
      , "to":158
    }
    ,
    {
      "from":139
      , "to":158
    }
    ,
    {
      "from":140
      , "to":158
    }
    ,
    {
      "from":136
      , "to":158
    }
    ,
    {
      "from":138
      , "to":142
    }
    ,
    {
      "from":139
      , "to":142
    }
    ,
    {
      "from":140
      , "to":142
    }
    ,
    {
      "from":136
      , "to":142
    }
    ,
    {
      "from":138
      , "to":155
    }
    ,
    {
      "from":139
      , "to":155
    }
    ,
    {
      "from":140
      , "to":155
    }
    ,
    {
      "from":136
      , "to":155
    }
    ,
    {
      "from":138
      , "to":161
    }
    ,
    {
      "from":139
      , "to":161
    }
    ,
    {
      "from":140
      , "to":161
    }
    ,
    {
      "from":136
      , "to":161
    }
    ,
    {
      "from":138
      , "to":164
    }
    ,
    {
      "from":139
      , "to":164
    }
    ,
    {
      "from":140
      , "to":164
    }
    ,
    {
      "from":136
      , "to":164
    }
    ,
    {
      "from":123
      , "to":124
    }
    ,
    {
      "from":121
      , "to":119
    }
    ,
    {
      "from":138
      , "to":148
    }
    ,
    {
      "from":139
      , "to":148
    }
    ,
    {
      "from":140
      , "to":148
    }
    ,
    {
      "from":136
      , "to":148
    }
    ,
    {
      "from":126
      , "to":127
    }
    ,
    {
      "from":138
      , "to":145
    }
    ,
    {
      "from":139
      , "to":145
    }
    ,
    {
      "from":140
      , "to":145
    }
    ,
    {
      "from":136
      , "to":145
    }
    ,
    {
      "from":138
      , "to":151
    }
    ,
    {
      "from":139
      , "to":151
    }
    ,
    {
      "from":140
      , "to":151
    }
    ,
    {
      "from":136
      , "to":151
    }
    ,
    {
      "from":124
      , "to":125
    }
    ,
    {
      "from":138
      , "to":154
    }
    ,
    {
      "from":139
      , "to":154
    }
    ,
    {
      "from":140
      , "to":154
    }
    ,
    {
      "from":136
      , "to":154
    }
    ,
    {
      "from":135
      , "to":133
    }
    ,
    {
      "from":167
      , "to":169
    }
    ,
    {
      "from":138
      , "to":162
    }
    ,
    {
      "from":139
      , "to":162
    }
    ,
    {
      "from":140
      , "to":162
    }
    ,
    {
      "from":136
      , "to":162
    }
    ,
    {
      "from":132
      , "to":122
    }
    ,
    {
      "from":169
      , "to":171
    }
    ,
    {
      "from":136
      , "to":139
    }
    ,
    {
      "from":138
      , "to":156
    }
    ,
    {
      "from":139
      , "to":156
    }
    ,
    {
      "from":140
      , "to":156
    }
    ,
    {
      "from":136
      , "to":156
    }
    ,
    {
      "from":138
      , "to":159
    }
    ,
    {
      "from":139
      , "to":159
    }
    ,
    {
      "from":140
      , "to":159
    }
    ,
    {
      "from":136
      , "to":159
    }
    ,
    {
      "from":171
      , "to":173
    }
    ,
    {
      "from":129
      , "to":130
    }
    ,
    {
      "from":128
      , "to":129
    }
    ,
    {
      "from":124
      , "to":129
    }
    ,
    {
      "from":126
      , "to":129
    }
    ,
    {
      "from":122
      , "to":129
    }
    ,
    {
      "from":138
      , "to":153
    }
    ,
    {
      "from":139
      , "to":153
    }
    ,
    {
      "from":140
      , "to":153
    }
    ,
    {
      "from":136
      , "to":153
    }
    ,
    {
      "from":138
      , "to":144
    }
    ,
    {
      "from":139
      , "to":144
    }
    ,
    {
      "from":140
      , "to":144
    }
    ,
    {
      "from":136
      , "to":144
    }
    ,
    {
      "from":166
      , "to":136
    }
    ,
    {
      "from":136
      , "to":138
    }
    ,
    {
      "from":138
      , "to":141
    }
    ,
    {
      "from":139
      , "to":141
    }
    ,
    {
      "from":140
      , "to":141
    }
    ,
    {
      "from":136
      , "to":141
    }
    ,
    {
      "from":138
      , "to":147
    }
    ,
    {
      "from":139
      , "to":147
    }
    ,
    {
      "from":140
      , "to":147
    }
    ,
    {
      "from":136
      , "to":147
    }
    ,
    {
      "from":122
      , "to":123
    }
    ,
    {
      "from":138
      , "to":163
    }
    ,
    {
      "from":139
      , "to":163
    }
    ,
    {
      "from":140
      , "to":163
    }
    ,
    {
      "from":136
      , "to":163
    }
    ,
    {
      "from":138
      , "to":150
    }
    ,
    {
      "from":139
      , "to":150
    }
    ,
    {
      "from":140
      , "to":150
    }
    ,
    {
      "from":136
      , "to":150
    }
    ,
    {
      "from":127
      , "to":128
    }
    ,
    {
      "from":138
      , "to":157
    }
    ,
    {
      "from":139
      , "to":157
    }
    ,
    {
      "from":140
      , "to":157
    }
    ,
    {
      "from":136
      , "to":157
    }
    ,
    {
      "from":138
      , "to":143
    }
    ,
    {
      "from":139
      , "to":143
    }
    ,
    {
      "from":140
      , "to":143
    }
    ,
    {
      "from":136
      , "to":143
    }
    ,
    {
      "from":138
      , "to":160
    }
    ,
    {
      "from":139
      , "to":160
    }
    ,
    {
      "from":140
      , "to":160
    }
    ,
    {
      "from":136
      , "to":160
    }
    ,
    {
      "from":176
      , "to":167
    }
    ,
    {
      "from":125
      , "to":126
    }
    ,
    {
      "from":166
      , "to":137
    }
    ,
    {
      "from":136
      , "to":140
    }
    ,
    {
      "from":138
      , "to":149
    }
    ,
    {
      "from":139
      , "to":149
    }
    ,
    {
      "from":140
      , "to":149
    }
    ,
    {
      "from":136
      , "to":149
    }
    ,
    {
      "from":138
      , "to":152
    }
    ,
    {
      "from":139
      , "to":152
    }
    ,
    {
      "from":140
      , "to":152
    }
    ,
    {
      "from":136
      , "to":152
    }
    ,
    {
      "from":138
      , "to":146
    }
    ,
    {
      "from":139
      , "to":146
    }
    ,
    {
      "from":140
      , "to":146
    }
    ,
    {
      "from":136
      , "to":146
    }
    ,
    {
      "from":131
      , "to":135
    }
    ,
    {
      "from":175
      , "to":117
    }
    ,
    {
      "from":133
      , "to":134
    }
    ,
    {
      "from":165
      , "to":176
    }
    ,
    {
      "from":165
      , "to":166
    }
    ,
    {
      "from":134
      , "to":166
    }
    ,
    {
      "from":119
      , "to":120
    }
    ,
    {
      "from":138
      , "to":165
    }
    ,
    {
      "from":139
      , "to":165
    }
    ,
    {
      "from":140
      , "to":165
    }
    ,
    {
      "from":136
      , "to":165
    }
    ,
    {
      "from":141
      , "to":165
    }
    ,
    {
      "from":142
      , "to":165
    }
    ,
    {
      "from":143
      , "to":165
    }
    ,
    {
      "from":144
      , "to":165
    }
    ,
    {
      "from":145
      , "to":165
    }
    ,
    {
      "from":146
      , "to":165
    }
    ,
    {
      "from":147
      , "to":165
    }
    ,
    {
      "from":148
      , "to":165
    }
    ,
    {
      "from":149
      , "to":165
    }
    ,
    {
      "from":150
      , "to":165
    }
    ,
    {
      "from":151
      , "to":165
    }
    ,
    {
      "from":152
      , "to":165
    }
    ,
    {
      "from":153
      , "to":165
    }
    ,
    {
      "from":154
      , "to":165
    }
    ,
    {
      "from":155
      , "to":165
    }
    ,
    {
      "from":156
      , "to":165
    }
    ,
    {
      "from":137
      , "to":165
    }
    ,
    {
      "from":157
      , "to":165
    }
    ,
    {
      "from":158
      , "to":165
    }
    ,
    {
      "from":159
      , "to":165
    }
    ,
    {
      "from":160
      , "to":165
    }
    ,
    {
      "from":161
      , "to":165
    }
    ,
    {
      "from":162
      , "to":165
    }
    ,
    {
      "from":163
      , "to":165
    }
    ,
    {
      "from":164
      , "to":165
    }
    ,
    {
      "from":175
      , "to":113
    }
    ,
    {
      "from":120
      , "to":113
    }
    ,
    {
      "from":130
      , "to":131
    }
    ,
    {
      "from":128
      , "to":131
    }
    ,
    {
      "from":129
      , "to":131
    }
    ,
    {
      "from":173
      , "to":175
    }
    ,
    {
      "from":131
      , "to":132
    }
    ,
    {
      "from":113
      , "to":132
    }
    ,
    {
      "from":27
      , "to":158
    }
    ,
    {
      "from":27
      , "to":142
    }
    ,
    {
      "from":27
      , "to":155
    }
    ,
    {
      "from":27
      , "to":161
    }
    ,
    {
      "from":27
      , "to":164
    }
    ,
    {
      "from":27
      , "to":119
    }
    ,
    {
      "from":27
      , "to":148
    }
    ,
    {
      "from":27
      , "to":145
    }
    ,
    {
      "from":27
      , "to":151
    }
    ,
    {
      "from":27
      , "to":154
    }
    ,
    {
      "from":133
      , "to":27
    }
    ,
    {
      "from":27
      , "to":162
    }
    ,
    {
      "from":27
      , "to":156
    }
    ,
    {
      "from":27
      , "to":159
    }
    ,
    {
      "from":27
      , "to":153
    }
    ,
    {
      "from":27
      , "to":144
    }
    ,
    {
      "from":27
      , "to":136
    }
    ,
    {
      "from":27
      , "to":147
    }
    ,
    {
      "from":27
      , "to":141
    }
    ,
    {
      "from":27
      , "to":163
    }
    ,
    {
      "from":27
      , "to":150
    }
    ,
    {
      "from":27
      , "to":160
    }
    ,
    {
      "from":27
      , "to":157
    }
    ,
    {
      "from":27
      , "to":143
    }
    ,
    {
      "from":27
      , "to":137
    }
    ,
    {
      "from":27
      , "to":149
    }
    ,
    {
      "from":27
      , "to":152
    }
    ,
    {
      "from":27
      , "to":146
    }
    ,
    {
      "from":74
      , "to":198
    }
    ,
    {
      "from":79
      , "to":200
    }
    ,
    {
      "from":84
      , "to":202
    }
    ,
    {
      "from":88
      , "to":204
    }
    ,
    {
      "from":92
      , "to":205
    }
    ,
    {
      "from":96
      , "to":206
    }
    ,
    {
      "from":232
      , "to":233
    }
    ,
    {
      "from":234
      , "to":235
    }
    ,
    {
      "from":236
      , "to":237
    }
    ,
    {
      "from":238
      , "to":239
    }
    ,
    {
      "from":246
      , "to":213
    }
    ,
    {
      "from":246
      , "to":214
    }
    ,
    {
      "from":199
      , "to":246
    }
    ,
    {
      "from":248
      , "to":215
    }
    ,
    {
      "from":248
      , "to":216
    }
    ,
    {
      "from":201
      , "to":248
    }
    ,
    {
      "from":250
      , "to":217
    }
    ,
    {
      "from":250
      , "to":218
    }
    ,
    {
      "from":203
      , "to":250
    }
    ,
    {
      "from":205
      , "to":206
    }
    ,
    {
      "from":198
      , "to":199
    }
    ,
    {
      "from":208
      , "to":198
    }
    ,
    {
      "from":212
      , "to":214
    }
    ,
    {
      "from":213
      , "to":222
    }
    ,
    {
      "from":214
      , "to":222
    }
    ,
    {
      "from":215
      , "to":222
    }
    ,
    {
      "from":216
      , "to":222
    }
    ,
    {
      "from":217
      , "to":222
    }
    ,
    {
      "from":218
      , "to":222
    }
    ,
    {
      "from":212
      , "to":222
    }
    ,
    {
      "from":236
      , "to":238
    }
    ,
    {
      "from":212
      , "to":217
    }
    ,
    {
      "from":197
      , "to":195
    }
    ,
    {
      "from":219
      , "to":225
    }
    ,
    {
      "from":221
      , "to":225
    }
    ,
    {
      "from":213
      , "to":225
    }
    ,
    {
      "from":214
      , "to":225
    }
    ,
    {
      "from":215
      , "to":225
    }
    ,
    {
      "from":216
      , "to":225
    }
    ,
    {
      "from":217
      , "to":225
    }
    ,
    {
      "from":218
      , "to":225
    }
    ,
    {
      "from":212
      , "to":225
    }
    ,
    {
      "from":212
      , "to":216
    }
    ,
    {
      "from":232
      , "to":234
    }
    ,
    {
      "from":197
      , "to":194
    }
    ,
    {
      "from":213
      , "to":227
    }
    ,
    {
      "from":214
      , "to":227
    }
    ,
    {
      "from":215
      , "to":227
    }
    ,
    {
      "from":216
      , "to":227
    }
    ,
    {
      "from":217
      , "to":227
    }
    ,
    {
      "from":218
      , "to":227
    }
    ,
    {
      "from":212
      , "to":227
    }
    ,
    {
      "from":219
      , "to":227
    }
    ,
    {
      "from":213
      , "to":223
    }
    ,
    {
      "from":214
      , "to":223
    }
    ,
    {
      "from":215
      , "to":223
    }
    ,
    {
      "from":216
      , "to":223
    }
    ,
    {
      "from":217
      , "to":223
    }
    ,
    {
      "from":218
      , "to":223
    }
    ,
    {
      "from":212
      , "to":223
    }
    ,
    {
      "from":202
      , "to":203
    }
    ,
    {
      "from":200
      , "to":201
    }
    ,
    {
      "from":241
      , "to":232
    }
    ,
    {
      "from":213
      , "to":229
    }
    ,
    {
      "from":214
      , "to":229
    }
    ,
    {
      "from":215
      , "to":229
    }
    ,
    {
      "from":216
      , "to":229
    }
    ,
    {
      "from":217
      , "to":229
    }
    ,
    {
      "from":218
      , "to":229
    }
    ,
    {
      "from":212
      , "to":229
    }
    ,
    {
      "from":221
      , "to":229
    }
    ,
    {
      "from":234
      , "to":236
    }
    ,
    {
      "from":201
      , "to":202
    }
    ,
    {
      "from":199
      , "to":200
    }
    ,
    {
      "from":211
      , "to":209
    }
    ,
    {
      "from":213
      , "to":220
    }
    ,
    {
      "from":214
      , "to":220
    }
    ,
    {
      "from":215
      , "to":220
    }
    ,
    {
      "from":216
      , "to":220
    }
    ,
    {
      "from":217
      , "to":220
    }
    ,
    {
      "from":218
      , "to":220
    }
    ,
    {
      "from":212
      , "to":220
    }
    ,
    {
      "from":213
      , "to":226
    }
    ,
    {
      "from":214
      , "to":226
    }
    ,
    {
      "from":215
      , "to":226
    }
    ,
    {
      "from":216
      , "to":226
    }
    ,
    {
      "from":217
      , "to":226
    }
    ,
    {
      "from":218
      , "to":226
    }
    ,
    {
      "from":212
      , "to":226
    }
    ,
    {
      "from":219
      , "to":226
    }
    ,
    {
      "from":212
      , "to":213
    }
    ,
    {
      "from":212
      , "to":218
    }
    ,
    {
      "from":231
      , "to":212
    }
    ,
    {
      "from":213
      , "to":221
    }
    ,
    {
      "from":214
      , "to":221
    }
    ,
    {
      "from":215
      , "to":221
    }
    ,
    {
      "from":216
      , "to":221
    }
    ,
    {
      "from":217
      , "to":221
    }
    ,
    {
      "from":218
      , "to":221
    }
    ,
    {
      "from":212
      , "to":221
    }
    ,
    {
      "from":212
      , "to":215
    }
    ,
    {
      "from":213
      , "to":228
    }
    ,
    {
      "from":214
      , "to":228
    }
    ,
    {
      "from":215
      , "to":228
    }
    ,
    {
      "from":216
      , "to":228
    }
    ,
    {
      "from":217
      , "to":228
    }
    ,
    {
      "from":218
      , "to":228
    }
    ,
    {
      "from":212
      , "to":228
    }
    ,
    {
      "from":221
      , "to":228
    }
    ,
    {
      "from":204
      , "to":205
    }
    ,
    {
      "from":200
      , "to":205
    }
    ,
    {
      "from":202
      , "to":205
    }
    ,
    {
      "from":198
      , "to":205
    }
    ,
    {
      "from":213
      , "to":219
    }
    ,
    {
      "from":214
      , "to":219
    }
    ,
    {
      "from":215
      , "to":219
    }
    ,
    {
      "from":216
      , "to":219
    }
    ,
    {
      "from":217
      , "to":219
    }
    ,
    {
      "from":218
      , "to":219
    }
    ,
    {
      "from":212
      , "to":219
    }
    ,
    {
      "from":219
      , "to":224
    }
    ,
    {
      "from":221
      , "to":224
    }
    ,
    {
      "from":213
      , "to":224
    }
    ,
    {
      "from":214
      , "to":224
    }
    ,
    {
      "from":215
      , "to":224
    }
    ,
    {
      "from":216
      , "to":224
    }
    ,
    {
      "from":217
      , "to":224
    }
    ,
    {
      "from":218
      , "to":224
    }
    ,
    {
      "from":212
      , "to":224
    }
    ,
    {
      "from":203
      , "to":204
    }
    ,
    {
      "from":230
      , "to":241
    }
    ,
    {
      "from":238
      , "to":240
    }
    ,
    {
      "from":207
      , "to":211
    }
    ,
    {
      "from":209
      , "to":210
    }
    ,
    {
      "from":206
      , "to":207
    }
    ,
    {
      "from":204
      , "to":207
    }
    ,
    {
      "from":205
      , "to":207
    }
    ,
    {
      "from":194
      , "to":196
    }
    ,
    {
      "from":195
      , "to":196
    }
    ,
    {
      "from":240
      , "to":193
    }
    ,
    {
      "from":207
      , "to":208
    }
    ,
    {
      "from":188
      , "to":208
    }
    ,
    {
      "from":230
      , "to":231
    }
    ,
    {
      "from":210
      , "to":231
    }
    ,
    {
      "from":222
      , "to":230
    }
    ,
    {
      "from":223
      , "to":230
    }
    ,
    {
      "from":213
      , "to":230
    }
    ,
    {
      "from":214
      , "to":230
    }
    ,
    {
      "from":215
      , "to":230
    }
    ,
    {
      "from":216
      , "to":230
    }
    ,
    {
      "from":217
      , "to":230
    }
    ,
    {
      "from":218
      , "to":230
    }
    ,
    {
      "from":212
      , "to":230
    }
    ,
    {
      "from":224
      , "to":230
    }
    ,
    {
      "from":220
      , "to":230
    }
    ,
    {
      "from":225
      , "to":230
    }
    ,
    {
      "from":226
      , "to":230
    }
    ,
    {
      "from":229
      , "to":230
    }
    ,
    {
      "from":228
      , "to":230
    }
    ,
    {
      "from":227
      , "to":230
    }
    ,
    {
      "from":240
      , "to":188
    }
    ,
    {
      "from":196
      , "to":188
    }
    ,
    {
      "from":27
      , "to":222
    }
    ,
    {
      "from":27
      , "to":195
    }
    ,
    {
      "from":27
      , "to":225
    }
    ,
    {
      "from":27
      , "to":194
    }
    ,
    {
      "from":27
      , "to":227
    }
    ,
    {
      "from":27
      , "to":223
    }
    ,
    {
      "from":27
      , "to":229
    }
    ,
    {
      "from":27
      , "to":220
    }
    ,
    {
      "from":209
      , "to":27
    }
    ,
    {
      "from":27
      , "to":226
    }
    ,
    {
      "from":27
      , "to":212
    }
    ,
    {
      "from":27
      , "to":221
    }
    ,
    {
      "from":27
      , "to":228
    }
    ,
    {
      "from":27
      , "to":219
    }
    ,
    {
      "from":27
      , "to":224
    }
    ,
    {
      "from":168
      , "to":255
    }
    ,
    {
      "from":233
      , "to":256
    }
    ,
    {
      "from":170
      , "to":257
    }
    ,
    {
      "from":235
      , "to":258
    }
    ,
    {
      "from":172
      , "to":259
    }
    ,
    {
      "from":237
      , "to":260
    }
    ,
    {
      "from":174
      , "to":261
    }
    ,
    {
      "from":239
      , "to":262
    }
    ,
    {
      "from":260
      , "to":264
    }
    ,
    {
      "from":259
      , "to":264
    }
    ,
    {
      "from":257
      , "to":265
    }
    ,
    {
      "from":258
      , "to":265
    }
    ,
    {
      "from":260
      , "to":261
    }
    ,
    {
      "from":259
      , "to":261
    }
    ,
    {
      "from":257
      , "to":260
    }
    ,
    {
      "from":258
      , "to":260
    }
    ,
    {
      "from":268
      , "to":256
    }
    ,
    {
      "from":255
      , "to":258
    }
    ,
    {
      "from":256
      , "to":258
    }
    ,
    {
      "from":257
      , "to":259
    }
    ,
    {
      "from":258
      , "to":259
    }
    ,
    {
      "from":261
      , "to":266
    }
    ,
    {
      "from":262
      , "to":266
    }
    ,
    {
      "from":255
      , "to":257
    }
    ,
    {
      "from":256
      , "to":257
    }
    ,
    {
      "from":260
      , "to":262
    }
    ,
    {
      "from":259
      , "to":262
    }
    ,
    {
      "from":268
      , "to":255
    }
    ,
    {
      "from":257
      , "to":263
    }
    ,
    {
      "from":258
      , "to":263
    }
    ,
    {
      "from":267
      , "to":254
    }
    ,
    {
      "from":257
      , "to":267
    }
    ,
    {
      "from":258
      , "to":267
    }
    ,
    {
      "from":266
      , "to":267
    }
    ,
    {
      "from":265
      , "to":267
    }
    ,
    {
      "from":264
      , "to":267
    }
    ,
    {
      "from":263
      , "to":267
    }
    ,
    {
      "from":267
      , "to":268
    }
    ,
    {
      "from":252
      , "to":268
    }
    ,
    {
      "from":264
      , "to":27
    }
    ,
    {
      "from":265
      , "to":27
    }
    ,
    {
      "from":266
      , "to":27
    }
    ,
    {
      "from":263
      , "to":27
    }
  ]
  , "fileIndexMap":
  {
    "/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl":"1"
    , "/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl":"2"
    , "/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl":"3"
    , "/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl":"4"
    , "/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl":"5"
  }
}
;var areaJSON={
  "columns":["ALUTs", "FFs", "RAMs", "DSPs"]
  , "debug_enabled":1
  , "total_percent":
  [56.2892, 31.4194, 27.1219, 105.126, 14.8221]
  , "total":
  [247635, 427528, 2502, 225]
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
    , {
      "name":"Krnl_GA.cl:11 (chan_GA2Conf_active)"
      , "data":
      [43, 65, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":11
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 8 bits wide by 64 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:12 (chan_GA2Conf_mode)"
      , "data":
      [8, 8, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":12
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 8 bits wide by 0 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:13 (chan_GA2Conf_cnt)"
      , "data":
      [32, 32, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":13
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 0 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:15 (chan_Conf2Intere_x)"
      , "data":
      [49, 167, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":15
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 128 deep. Requested depth was 90.\nChannel depth was changed for the following reasons:\n- instruction scheduling requirements\n- nature of underlying FIFO implementation"
      ]
    }
    , {
      "name":"Krnl_GA.cl:16 (chan_Conf2Intere_y)"
      , "data":
      [49, 167, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":16
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 128 deep. Requested depth was 90.\nChannel depth was changed for the following reasons:\n- instruction scheduling requirements\n- nature of underlying FIFO implementation"
      ]
    }
    , {
      "name":"Krnl_GA.cl:17 (chan_Conf2Intere_z)"
      , "data":
      [49, 167, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":17
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 128 deep. Requested depth was 90.\nChannel depth was changed for the following reasons:\n- instruction scheduling requirements\n- nature of underlying FIFO implementation"
      ]
    }
    , {
      "name":"Krnl_GA.cl:18 (chan_Conf2Intere_active)"
      , "data":
      [10, 37, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":18
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 8 bits wide by 3 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:19 (chan_Conf2Intere_mode)"
      , "data":
      [10, 37, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":19
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 8 bits wide by 3 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:20 (chan_Conf2Intere_cnt)"
      , "data":
      [10, 133, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":20
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 3 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:22 (chan_Conf2Intrae_x)"
      , "data":
      [49, 167, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":22
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 128 deep. Requested depth was 90.\nChannel depth was changed for the following reasons:\n- instruction scheduling requirements\n- nature of underlying FIFO implementation"
      ]
    }
    , {
      "name":"Krnl_GA.cl:23 (chan_Conf2Intrae_y)"
      , "data":
      [49, 167, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":23
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 128 deep. Requested depth was 90.\nChannel depth was changed for the following reasons:\n- instruction scheduling requirements\n- nature of underlying FIFO implementation"
      ]
    }
    , {
      "name":"Krnl_GA.cl:24 (chan_Conf2Intrae_z)"
      , "data":
      [49, 167, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":24
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 128 deep. Requested depth was 90.\nChannel depth was changed for the following reasons:\n- instruction scheduling requirements\n- nature of underlying FIFO implementation"
      ]
    }
    , {
      "name":"Krnl_GA.cl:25 (chan_Conf2Intrae_active)"
      , "data":
      [10, 37, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":25
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 8 bits wide by 3 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:26 (chan_Conf2Intrae_mode)"
      , "data":
      [10, 37, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":26
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 8 bits wide by 3 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:27 (chan_Conf2Intrae_cnt)"
      , "data":
      [10, 133, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":27
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 3 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:29 (chan_Intere2Store_intere)"
      , "data":
      [49, 167, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":29
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 512 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:30 (chan_Intere2Store_active)"
      , "data":
      [43, 65, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":30
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 8 bits wide by 512 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:31 (chan_Intere2Store_mode)"
      , "data":
      [43, 65, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":31
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 8 bits wide by 512 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:32 (chan_Intere2Store_cnt)"
      , "data":
      [49, 167, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":32
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 512 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:34 (chan_Intrae2Store_intrae)"
      , "data":
      [10, 133, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":34
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 3 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:35 (chan_Intrae2Store_active)"
      , "data":
      [8, 8, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":35
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 8 bits wide by 0 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:36 (chan_Intrae2Store_mode)"
      , "data":
      [8, 8, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":36
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 8 bits wide by 0 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:37 (chan_Intrae2Store_cnt)"
      , "data":
      [32, 32, 0, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":37
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 0 deep."
      ]
    }
    , {
      "name":"Krnl_GA.cl:8 (chan_GA2Conf_genotype)"
      , "data":
      [49, 167, 1, 0]
      , "debug":
      [
        [
          {
            "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
            , "line":8
          }
        ]
      ]
      , "details":
      [
        "Channel is implemented 32 bits wide by 64 deep. Requested depth was 38.\nChannel depth was changed for the following reasons:\n- instruction scheduling requirements\n- nature of underlying FIFO implementation"
      ]
    }
  ]
  , "functions":
  [
    {
      "name":"Krnl_Conform"
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
          [1570, 1685, 0, 0]
          , "details":
          [
            "Kernel dispatch logic."
          ]
        }
        , {
          "name":"Krnl_Conform.cl:18 (loc_coords_x)"
          , "data":
          [33, 256, 2, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                , "line":18
              }
            ]
          ]
          , "details":
          [
            "Local memory: Optimal.\nRequested size 512 bytes (rounded up to nearest power of 2), implemented size 512 bytes, stall-free, 2 reads and 1 write. Additional information:\n- Reducing accesses to exactly one read and one write for all on-chip memory systems may increase overall system performance."
          ]
        }
        , {
          "name":"Krnl_Conform.cl:19 (loc_coords_y)"
          , "data":
          [33, 256, 2, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                , "line":19
              }
            ]
          ]
          , "details":
          [
            "Local memory: Optimal.\nRequested size 512 bytes (rounded up to nearest power of 2), implemented size 512 bytes, stall-free, 2 reads and 1 write. Additional information:\n- Reducing accesses to exactly one read and one write for all on-chip memory systems may increase overall system performance."
          ]
        }
        , {
          "name":"Krnl_Conform.cl:20 (loc_coords_z)"
          , "data":
          [33, 256, 2, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                , "line":20
              }
            ]
          ]
          , "details":
          [
            "Local memory: Optimal.\nRequested size 512 bytes (rounded up to nearest power of 2), implemented size 512 bytes, stall-free, 2 reads and 1 write. Additional information:\n- Reducing accesses to exactly one read and one write for all on-chip memory systems may increase overall system performance."
          ]
        }
        , {
          "name":"Krnl_Conform.cl:21 (genotype)"
          , "data":
          [130, 1024, 8, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                , "line":21
              }
            ]
          ]
          , "details":
          [
            "Local memory: Optimal.\nRequested size 256 bytes (rounded up to nearest power of 2), implemented size 256 bytes, stall-free, 5 reads and 1 write. Additional information:\n- Banked on lowest dimension into 2 separate banks (this is a good thing).\n- Reducing accesses to exactly one read and one write for all on-chip memory systems may increase overall system performance."
          ]
        }
        , {
          "name":"Private Variable: \n - 'pipe_cnt' (Krnl_Conform.cl:234)"
          , "data":
          [24, 101, 0, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                , "line":234
              }
            ]
          ]
          , "details":
          [
            "Implemented using registers of the following size:\n- 1 register of width 32 and depth 1"
          ]
        }
        , {
          "name":"Private Variable: \n - 'pipe_cnt' (Krnl_Conform.cl:47)"
          , "data":
          [4, 66.5, 0, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                , "line":47
              }
            ]
          ]
          , "details":
          [
            "Implemented using registers of the following size:\n- 1 register of width 32 and depth 1"
          ]
        }
        , {
          "name":"Private Variable: \n - 'rotation_counter' (Krnl_Conform.cl:79)"
          , "data":
          [40, 34, 1, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                , "line":79
              }
            ]
          ]
          , "details":
          [
            "Implemented using registers of the following size:\n- 1 register of width 32 and depth 48 (depth was increased by a factor of 45 due to a loop initiation interval of 45.)\nReducing the scope of the variable may reduce its depth (e.g. moving declaration inside a loop or using it as soon as possible)."
          ]
        }
      ]
      , "basicblocks":
      [
        {
          "name":"Block10"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [0, 16, 0, 0]
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
                    [0, 16, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
          ]
        }
        , {
          "name":"Block3.wii_blk"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [700, 700, 0, 0]
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
                    "name":"Krnl_Conform.cl:155"
                    , "data":
                    [256, 256, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":155
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:234"
                    , "data":
                    [136, 136, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":234
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:79"
                    , "data":
                    [144, 144, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":79
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [132, 132, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_Conform.cl:79"
              , "data":
              [1, 129, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":79
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [1, 129, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:155"
              , "data":
              [2, 258, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":155
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [2, 258, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:234"
              , "data":
              [1, 129, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":234
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [1, 129, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
        , {
          "name":"Block4"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [256, 384, 0, 0]
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
                    [256, 384, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
          ]
        }
        , {
          "name":"Block5"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [32, 276, 0, 0]
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
                    [32, 276, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
          ]
        }
        , {
          "name":"Block6"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [168, 361, 1, 0]
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
                    [33, 81, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:47"
                    , "data":
                    [0, 36, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":47
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:48"
                    , "data":
                    [87, 142, 1, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":48
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [48, 102, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Feedback"
              , "data":
              [19, 91.5, 0, 0]
              , "details":
              [
                "Resources for loop-carried dependencies. To reduce this area:\n- reduce number and size of loop-carried variables"
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:47"
                    , "data":
                    [15, 25, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":47
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [4, 66.5, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Cluster logic"
              , "data":
              [218, 502, 2, 0]
              , "details":
              [
                "Logic required to efficiently support sets of operations that do not stall. This area cannot be affected directly."
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_Conform.cl:48"
              , "data":
              [34, 24, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":48
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
                    [34, 24, 0, 0]
                    , "details":
                    [
                      "Stall-free write to memory declared on Krnl_Conform.cl:21."
                    ]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
        , {
          "name":"Block7"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [314, 1051, 2, 0]
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
                    [32, 48, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:110"
                    , "data":
                    [0, 32, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":110
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:111"
                    , "data":
                    [0, 32, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":111
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:112"
                    , "data":
                    [0, 32, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":112
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:51"
                    , "data":
                    [46, 61, 1, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":51
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:52"
                    , "data":
                    [82, 392.5, 0.5, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":52
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:54"
                    , "data":
                    [0, 8, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":54
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:55"
                    , "data":
                    [0, 32, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":55
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:59"
                    , "data":
                    [16, 32, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":59
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:60"
                    , "data":
                    [16, 32, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":60
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:61"
                    , "data":
                    [0, 32, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":61
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:68"
                    , "data":
                    [24, 80, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":68
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:69"
                    , "data":
                    [24, 80, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":69
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:70"
                    , "data":
                    [0, 32, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":70
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:79"
                    , "data":
                    [74, 125.5, 0.5, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":79
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Cluster logic"
              , "data":
              [701, 1537, 6, 0]
              , "details":
              [
                "Logic required to efficiently support sets of operations that do not stall. This area cannot be affected directly."
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_Conform.cl:52"
              , "data":
              [1535, 3793, 16, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":52
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
            , {
              "name":"Krnl_Conform.cl:59"
              , "data":
              [15, 8, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":59
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [15, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:21."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:60"
              , "data":
              [7.5, 4, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":60
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [7.5, 4, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:21."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:61"
              , "data":
              [7.5, 4, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":61
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [7.5, 4, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:21."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:68"
              , "data":
              [1471, 4226, 8, 10]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":68
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'__acl__sincosf' Function Call"
                    , "data":
                    [1471, 4226, 8, 9]
                  }
                  , "count":2
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:69"
              , "data":
              [735.5, 2113, 4, 5.5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":69
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'__acl__sincosf' Function Call"
                    , "data":
                    [735.5, 2113, 4, 4.5]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:70"
              , "data":
              [735.5, 2113, 4, 4.5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":70
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'__acl__sincosf' Function Call"
                    , "data":
                    [735.5, 2113, 4, 4.5]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:110"
              , "data":
              [7.5, 4, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":110
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [7.5, 4, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:21."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:111"
              , "data":
              [7.5, 4, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":111
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [7.5, 4, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:21."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:112"
              , "data":
              [15, 8, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":112
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [15, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:21."
                    ]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
        , {
          "name":"Block8"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [4132.87, 7437.1, 29.8667, 0]
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
                    [33, 81, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:108"
                    , "data":
                    [5.33333, 10.6667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":108
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:110"
                    , "data":
                    [17.875, 22.4699, 0.526786, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":110
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:111"
                    , "data":
                    [17.875, 22.4699, 0.526786, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":111
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:112"
                    , "data":
                    [25.875, 38.7699, 0.526786, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":112
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:118"
                    , "data":
                    [43.8333, 66.8788, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":118
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:119"
                    , "data":
                    [28.8333, 36.8788, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":119
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:120"
                    , "data":
                    [44.7083, 56.9413, 0.5625, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":120
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:121"
                    , "data":
                    [17.3333, 35.7121, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":121
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:123"
                    , "data":
                    [34.2083, 39.8341, 0.383929, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":123
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:124"
                    , "data":
                    [34.2083, 39.8341, 0.383929, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":124
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:125"
                    , "data":
                    [42.2083, 56.1341, 0.383929, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":125
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:129"
                    , "data":
                    [51.2222, 89.8333, 0.611111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":129
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:130"
                    , "data":
                    [51.2222, 89.8333, 0.611111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":130
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:131"
                    , "data":
                    [51.2222, 90.1667, 0.611111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":131
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:135"
                    , "data":
                    [32, 70, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":135
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:136"
                    , "data":
                    [78.475, 144.251, 0.633929, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":136
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:139"
                    , "data":
                    [92.8083, 162.417, 1.13393, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":139
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:140"
                    , "data":
                    [96.8083, 170.417, 1.13393, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":140
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:141"
                    , "data":
                    [57.475, 112.751, 0.133929, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":141
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:155"
                    , "data":
                    [148.608, 284.517, 0.633929, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":155
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:159"
                    , "data":
                    [147.608, 293.017, 0.133929, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":159
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:163"
                    , "data":
                    [146.275, 290.351, 0.133929, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":163
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:167"
                    , "data":
                    [152.942, 303.684, 0.133929, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":167
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:174"
                    , "data":
                    [105.333, 210.667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":174
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:178"
                    , "data":
                    [81.8667, 163.733, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":178
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:181"
                    , "data":
                    [148.867, 287.233, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":181
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:184"
                    , "data":
                    [202.233, 388.717, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":184
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:188"
                    , "data":
                    [371.233, 709.217, 1.33333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":188
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:193"
                    , "data":
                    [253.233, 494.217, 0.333333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":193
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:198"
                    , "data":
                    [333.233, 654.217, 0.333333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":198
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:205"
                    , "data":
                    [93.1667, 138.219, 2.47619, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":205
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:206"
                    , "data":
                    [93.1667, 132.219, 2.47619, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":206
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:207"
                    , "data":
                    [93.1667, 132.469, 2.47619, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":207
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:61"
                    , "data":
                    [13.3333, 26.8121, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":61
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:68"
                    , "data":
                    [8, 16.1455, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":68
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:69"
                    , "data":
                    [8, 16.1455, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":69
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:70"
                    , "data":
                    [25.875, 37.4937, 0.705357, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":70
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:79"
                    , "data":
                    [187.6, 369.2, 2.2, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":79
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:81"
                    , "data":
                    [80, 140, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":81
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:85"
                    , "data":
                    [24.3333, 53, 0.333333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":85
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:88"
                    , "data":
                    [42.3333, 96.5, 1.33333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":88
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:90"
                    , "data":
                    [107.556, 138.167, 0.611111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":90
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:91"
                    , "data":
                    [107.556, 138.167, 0.611111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":91
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:92"
                    , "data":
                    [107.556, 139, 0.611111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":92
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:96"
                    , "data":
                    [50.5556, 81.5, 0.944444, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":96
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:97"
                    , "data":
                    [50.5556, 81.5, 0.944444, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":97
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:98"
                    , "data":
                    [54.5556, 91.3333, 0.944444, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":98
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [37.6, 92.4, 2, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Feedback"
              , "data":
              [140, 110, 2, 0]
              , "details":
              [
                "Resources for loop-carried dependencies. To reduce this area:\n- reduce number and size of loop-carried variables"
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:205"
                    , "data":
                    [25, 19, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":205
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:206"
                    , "data":
                    [25, 19, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":206
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:207"
                    , "data":
                    [25, 19, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":207
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:79"
                    , "data":
                    [25, 19, 1, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":79
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [40, 34, 1, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Cluster logic"
              , "data":
              [1068.13, 2720.9, 16.1333, 0]
              , "details":
              [
                "Logic required to efficiently support sets of operations that do not stall. This area cannot be affected directly."
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_Conform.cl:61"
              , "data":
              [0, 0, 0, 0.333333]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":61
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 0.333333]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:79"
              , "data":
              [16, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":79
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
              "name":"Krnl_Conform.cl:81"
              , "data":
              [317, 306, 13, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":81
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [317, 306, 13, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:90"
              , "data":
              [421, 663, 13, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":90
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [421, 663, 13, 0]
                    , "details":
                    [
                      "Load with a private 1024 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:91"
              , "data":
              [421, 663, 13, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":91
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [421, 663, 13, 0]
                    , "details":
                    [
                      "Load with a private 1024 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:92"
              , "data":
              [421, 663, 13, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":92
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [421, 663, 13, 0]
                    , "details":
                    [
                      "Load with a private 1024 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:96"
              , "data":
              [9, 8, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":96
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [9, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:18."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:97"
              , "data":
              [9, 8, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":97
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [9, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:19."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:98"
              , "data":
              [9, 8, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":98
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [9, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:20."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:108"
              , "data":
              [0, 0, 0, 0.333333]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":108
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 0.333333]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:116"
              , "data":
              [2, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":116
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [2, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:118"
              , "data":
              [1153.33, 1265, 14.3333, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":118
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [2, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [1151.33, 1265, 14.3333, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:119"
              , "data":
              [1151.33, 1265, 14.3333, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":119
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [1151.33, 1265, 14.3333, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:120"
              , "data":
              [1151.33, 1265, 14.3333, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":120
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [1151.33, 1265, 14.3333, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:121"
              , "data":
              [15, 8, 0, 0.333333]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":121
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 0.333333]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [15, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:21."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:123"
              , "data":
              [1151.33, 1265, 14.3333, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":123
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [1151.33, 1265, 14.3333, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:124"
              , "data":
              [1151.33, 1265, 14.3333, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":124
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [1151.33, 1265, 14.3333, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:125"
              , "data":
              [1151.33, 1265, 14.3333, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":125
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [1151.33, 1265, 14.3333, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:129"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":129
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:130"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":130
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:131"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":131
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:135"
              , "data":
              [23, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":135
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [8, 0, 0, 0]
                  }
                  , "count":2
                }
                , {
                  "info":
                  {
                    "name":"And"
                    , "data":
                    [8, 0, 0, 0]
                  }
                  , "count":4
                }
                , {
                  "info":
                  {
                    "name":"Or"
                    , "data":
                    [7, 0, 0, 0]
                  }
                  , "count":5
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:136"
              , "data":
              [735.5, 2113, 4, 4.5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":136
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'__acl__sincosf' Function Call"
                    , "data":
                    [735.5, 2113, 4, 4.5]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:137"
              , "data":
              [735.5, 2113, 4, 4.5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":137
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'__acl__sincosf' Function Call"
                    , "data":
                    [735.5, 2113, 4, 4.5]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:139"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":139
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:140"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":140
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:141"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":141
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:155"
              , "data":
              [0, 0, 0, 6]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":155
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":2
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Product Difference of Size 2 (a2*b2 - a1*b1)"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:159"
              , "data":
              [0, 0, 0, 5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":159
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply-Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:163"
              , "data":
              [0, 0, 0, 5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":163
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply-Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:167"
              , "data":
              [0, 0, 0, 5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":167
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply-Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:174"
              , "data":
              [0, 0, 0, 5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":174
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 3]
                  }
                  , "count":3
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:178"
              , "data":
              [0, 0, 0, 4]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":178
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:181"
              , "data":
              [0, 0, 0, 3]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":181
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply-Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Product Difference of Size 2 (a2*b2 - a1*b1)"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:184"
              , "data":
              [0, 0, 0, 4]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":184
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:188"
              , "data":
              [0, 0, 0, 5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":188
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":2
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply-Add"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":2
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:193"
              , "data":
              [0, 0, 0, 5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":193
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":2
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:198"
              , "data":
              [0, 0, 0, 5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":198
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":2
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:205"
              , "data":
              [34, 24, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":205
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Store"
                    , "data":
                    [34, 24, 0, 0]
                    , "details":
                    [
                      "Stall-free write to memory declared on Krnl_Conform.cl:18."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:206"
              , "data":
              [34, 24, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":206
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Store"
                    , "data":
                    [34, 24, 0, 0]
                    , "details":
                    [
                      "Stall-free write to memory declared on Krnl_Conform.cl:19."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:207"
              , "data":
              [34, 24, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":207
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Store"
                    , "data":
                    [34, 24, 0, 0]
                    , "details":
                    [
                      "Stall-free write to memory declared on Krnl_Conform.cl:20."
                    ]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
        , {
          "name":"Block9"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [417, 1701, 10, 0]
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
                    [33, 177, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:234"
                    , "data":
                    [47.1667, 487.667, 3.5, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":234
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:235"
                    , "data":
                    [18.75, 34.1667, 0.0833333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":235
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:236"
                    , "data":
                    [2.75, 2.16667, 0.0833333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":236
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:238"
                    , "data":
                    [6.05, 4.76667, 0.183333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":238
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:239"
                    , "data":
                    [6.05, 4.76667, 0.183333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":239
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:241"
                    , "data":
                    [26.3, 24.1417, 0.308333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":241
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:242"
                    , "data":
                    [26.3, 24.1417, 0.308333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":242
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:244"
                    , "data":
                    [11.6333, 9.30833, 0.308333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":244
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:245"
                    , "data":
                    [11.6333, 9.30833, 0.308333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":245
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:246"
                    , "data":
                    [2, 2, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":246
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:247"
                    , "data":
                    [21.8833, 19.3083, 0.308333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":247
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:248"
                    , "data":
                    [21.8833, 19.3083, 0.308333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":248
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:250"
                    , "data":
                    [17.8833, 14.8083, 0.308333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":250
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:251"
                    , "data":
                    [17.8833, 14.8083, 0.308333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":251
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [145.833, 853.333, 3.5, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Feedback"
              , "data":
              [15, 75, 0, 0]
              , "details":
              [
                "Resources for loop-carried dependencies. To reduce this area:\n- reduce number and size of loop-carried variables"
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Krnl_Conform.cl:234"
                    , "data":
                    [7, 6, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                          , "line":234
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [8, 69, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Cluster logic"
              , "data":
              [702, 1609, 7, 0]
              , "details":
              [
                "Logic required to efficiently support sets of operations that do not stall. This area cannot be affected directly."
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_Conform.cl:234"
              , "data":
              [16, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":234
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
              "name":"Krnl_Conform.cl:235"
              , "data":
              [9, 8, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":235
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [9, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:18."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:238"
              , "data":
              [9, 8, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":238
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [9, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:19."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_Conform.cl:241"
              , "data":
              [9, 8, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl"
                    , "line":241
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [9, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_Conform.cl:20."
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
    , {
      "name":"Krnl_GA"
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
          [1570, 1685, 0, 0]
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
              [96, 96, 0, 0]
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
                    "name":"Krnl_GA.cl:615"
                    , "data":
                    [64, 64, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
                          , "line":615
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
              "name":"Krnl_GA.cl:615"
              , "data":
              [1535, 3793, 16, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
                    , "line":615
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
        , {
          "name":"Block1"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [9, 14, 0, 0]
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
                    [1, 1, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_GA.cl:624"
                    , "data":
                    [8, 9.5, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
                          , "line":624
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [0, 3.5, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Feedback"
              , "data":
              [34, 64, 0, 0]
              , "details":
              [
                "Resources for loop-carried dependencies. To reduce this area:\n- reduce number and size of loop-carried variables"
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Krnl_GA.cl:624"
                    , "data":
                    [34, 64, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
                          , "line":624
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Cluster logic"
              , "data":
              [218, 502, 2, 0]
              , "details":
              [
                "Logic required to efficiently support sets of operations that do not stall. This area cannot be affected directly."
              ]
            }
          ]
          , "computation":
          [
          ]
        }
        , {
          "name":"Block2"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [33, 15, 0, 0]
              , "details":
              [
                "Resources for live values and control logic. To reduce this area:\n- reduce size of local variables\n- reduce scope of local variables, localizing them as much as possible\n- reduce number of nested loops"
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Krnl_GA.cl:627"
                    , "data":
                    [11, 5, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
                          , "line":627
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_GA.cl:628"
                    , "data":
                    [11, 5, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
                          , "line":628
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_GA.cl:629"
                    , "data":
                    [11, 5, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
                          , "line":629
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
              "name":"Krnl_GA.cl:633"
              , "data":
              [1790, 1557, 16, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
                    , "line":633
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
                    [1790, 1557, 16, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_GA.cl:634"
              , "data":
              [1790, 1557, 16, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl"
                    , "line":634
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
                    [1790, 1557, 16, 0]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
      ]
    }
    , {
      "name":"Krnl_InterE"
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
          [1570, 1685, 0, 0]
          , "details":
          [
            "Kernel dispatch logic."
          ]
        }
        , {
          "name":"Krnl_InterE.cl:29 (loc_coords_x)"
          , "data":
          [0, 0, 1, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                , "line":29
              }
            ]
          ]
          , "details":
          [
            "Private memory implemented in on-chip block RAM."
            , "Private memory: Optimal.\nRequested size 512 bytes (rounded up to nearest power of 2), implemented size 512 bytes, stall-free, 1 read and 1 write. Additional information:\n- No additional details."
          ]
        }
        , {
          "name":"Krnl_InterE.cl:30 (loc_coords_y)"
          , "data":
          [0, 0, 1, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                , "line":30
              }
            ]
          ]
          , "details":
          [
            "Private memory implemented in on-chip block RAM."
            , "Private memory: Optimal.\nRequested size 512 bytes (rounded up to nearest power of 2), implemented size 512 bytes, stall-free, 1 read and 1 write. Additional information:\n- No additional details."
          ]
        }
        , {
          "name":"Krnl_InterE.cl:31 (loc_coords_z)"
          , "data":
          [0, 0, 1, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                , "line":31
              }
            ]
          ]
          , "details":
          [
            "Private memory implemented in on-chip block RAM."
            , "Private memory: Optimal.\nRequested size 512 bytes (rounded up to nearest power of 2), implemented size 512 bytes, stall-free, 1 read and 1 write. Additional information:\n- No additional details."
          ]
        }
        , {
          "name":"Private Variable: \n - 'atom1_id' (Krnl_InterE.cl:39)"
          , "data":
          [34, 28, 1, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                , "line":39
              }
            ]
          ]
          , "details":
          [
            "Implemented using registers of the following size:\n- 1 register of width 8 and depth 13 (depth was increased by a factor of 13 due to a loop initiation interval of 13.)\nReducing the scope of the variable may reduce its depth (e.g. moving declaration inside a loop or using it as soon as possible)."
          ]
        }
        , {
          "name":"Private Variable: \n - 'interE' (Krnl_InterE.cl:38)"
          , "data":
          [72, 130, 1, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                , "line":38
              }
            ]
          ]
          , "details":
          [
            "Implemented using registers of the following size:\n- 1 register of width 32 and depth 13 (depth was increased by a factor of 13 due to a loop initiation interval of 13.)\nReducing the scope of the variable may reduce its depth (e.g. moving declaration inside a loop or using it as soon as possible)."
          ]
        }
        , {
          "name":"Private Variable: \n - 'pipe_cnt' (Krnl_InterE.cl:61)"
          , "data":
          [24, 101, 0, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                , "line":61
              }
            ]
          ]
          , "details":
          [
            "Implemented using registers of the following size:\n- 1 register of width 32 and depth 1"
          ]
        }
      ]
      , "basicblocks":
      [
        {
          "name":"Block11.wii_blk"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [490, 490, 0, 0]
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
                    "name":"Krnl_InterE.cl:181"
                    , "data":
                    [25.6, 25.6, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":181
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:182"
                    , "data":
                    [10.6667, 10.6667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":182
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:212"
                    , "data":
                    [10.6667, 10.6667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":212
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:47"
                    , "data":
                    [25.6, 25.6, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":47
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:48"
                    , "data":
                    [25.6, 25.6, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":48
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:49"
                    , "data":
                    [41.6, 41.6, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":49
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:61"
                    , "data":
                    [29.6, 29.6, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":61
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:87"
                    , "data":
                    [2, 2, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":87
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [286.667, 286.667, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_InterE.cl:47"
              , "data":
              [0.8, 26.4, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":47
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [0.8, 26.4, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:48"
              , "data":
              [0.8, 58.4, 0, 2]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":48
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [0.8, 26.4, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Mul"
                    , "data":
                    [0, 32, 0, 2]
                    , "details":
                    [
                      "This instruction does not depend on thread ID. Consider moving it, and all related instructions to the host to save area."
                      , "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:49"
              , "data":
              [0.8, 58.4, 0, 2]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":49
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [0.8, 26.4, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Mul"
                    , "data":
                    [0, 32, 0, 2]
                    , "details":
                    [
                      "This instruction does not depend on thread ID. Consider moving it, and all related instructions to the host to save area."
                      , "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:61"
              , "data":
              [0.8, 26.4, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":61
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [0.8, 26.4, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:96"
              , "data":
              [516, 771, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":96
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Integer to Floating Point Conversion"
                    , "data":
                    [516, 771, 0, 0]
                    , "details":
                    [
                      "This instruction does not depend on thread ID. Consider moving it, and all related instructions to the host to save area."
                      , "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":3
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:181"
              , "data":
              [0.8, 26.4, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":181
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [0.8, 26.4, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:182"
              , "data":
              [0, 32, 0, 2]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":182
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Mul"
                    , "data":
                    [0, 32, 0, 2]
                    , "details":
                    [
                      "This instruction does not depend on thread ID. Consider moving it, and all related instructions to the host to save area."
                      , "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:212"
              , "data":
              [0, 32, 0, 2]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":212
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Mul"
                    , "data":
                    [0, 32, 0, 2]
                    , "details":
                    [
                      "This instruction does not depend on thread ID. Consider moving it, and all related instructions to the host to save area."
                      , "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
        , {
          "name":"Block12"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [33, 405, 0, 0]
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
                    [33, 357, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:34"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":34
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:35"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":35
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:36"
                    , "data":
                    [0, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":36
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:68"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":68
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:70"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":70
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:72"
                    , "data":
                    [0, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":72
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
          ]
        }
        , {
          "name":"Block13"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [478, 1041, 1, 0]
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
                    [33, 81, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:61"
                    , "data":
                    [26, 107.333, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":61
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:62"
                    , "data":
                    [32.4583, 30.7778, 0.222222, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":62
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:64"
                    , "data":
                    [43.4405, 118.183, 0.222222, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":64
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:66"
                    , "data":
                    [62.1905, 290.116, 0.222222, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":66
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:68"
                    , "data":
                    [15.3036, 21.3079, 0.111111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":68
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:69"
                    , "data":
                    [106, 82, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":69
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:70"
                    , "data":
                    [19.8036, 25.3079, 0.111111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":70
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:72"
                    , "data":
                    [27.8036, 56.3079, 0.111111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":72
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [112, 228.667, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Feedback"
              , "data":
              [15, 75, 0, 0]
              , "details":
              [
                "Resources for loop-carried dependencies. To reduce this area:\n- reduce number and size of loop-carried variables"
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:61"
                    , "data":
                    [7, 6, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":61
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [8, 69, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Cluster logic"
              , "data":
              [218, 502, 2, 0]
              , "details":
              [
                "Logic required to efficiently support sets of operations that do not stall. This area cannot be affected directly."
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_InterE.cl:61"
              , "data":
              [16, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":61
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
              "name":"Krnl_InterE.cl:62"
              , "data":
              [34, 24, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":62
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
                    [34, 24, 0, 0]
                    , "details":
                    [
                      "Stall-free write to memory declared on Krnl_InterE.cl:29."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:64"
              , "data":
              [34, 24, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":64
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
                    [34, 24, 0, 0]
                    , "details":
                    [
                      "Stall-free write to memory declared on Krnl_InterE.cl:30."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:66"
              , "data":
              [34, 24, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":66
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
                    [34, 24, 0, 0]
                    , "details":
                    [
                      "Stall-free write to memory declared on Krnl_InterE.cl:31."
                    ]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
        , {
          "name":"Block14"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [126, 482, 0, 0]
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
                    [32, 48, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:34"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":34
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:35"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":35
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:36"
                    , "data":
                    [0, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":36
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:68"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":68
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:70"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":70
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:72"
                    , "data":
                    [0, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":72
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:77"
                    , "data":
                    [54, 337, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":77
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [40, 49, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_InterE.cl:77"
              , "data":
              [1535, 3793, 16, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":77
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
        , {
          "name":"Block15"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [5184.01, 18267, 44, 0]
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
                    [33, 225, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:101"
                    , "data":
                    [4.66667, 3, 0.333333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":101
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:105"
                    , "data":
                    [3.2, 6.4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":105
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:108"
                    , "data":
                    [3.2, 6.4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":108
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:111"
                    , "data":
                    [192, 384, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":111
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:115"
                    , "data":
                    [48.2667, 96.5333, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":115
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:116"
                    , "data":
                    [49.3333, 98.6667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":116
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:117"
                    , "data":
                    [89.3333, 178.667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":117
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:118"
                    , "data":
                    [110.667, 221.333, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":118
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:119"
                    , "data":
                    [29.6, 59.2, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":119
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:120"
                    , "data":
                    [93.6, 187.2, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":120
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:121"
                    , "data":
                    [61.6, 123.2, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":121
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:122"
                    , "data":
                    [61.6, 123.2, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":122
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:142"
                    , "data":
                    [8, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":142
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:143"
                    , "data":
                    [8, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":143
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:144"
                    , "data":
                    [8, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":144
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:145"
                    , "data":
                    [8, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":145
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:146"
                    , "data":
                    [8, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":146
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:147"
                    , "data":
                    [8, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":147
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:148"
                    , "data":
                    [8, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":148
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:149"
                    , "data":
                    [8, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":149
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:150"
                    , "data":
                    [22, 23, 1, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":150
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:153"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":153
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:154"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":154
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:155"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":155
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:156"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":156
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:157"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":157
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:158"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":158
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:159"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":159
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:160"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":160
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:174"
                    , "data":
                    [523.333, 857.667, 9, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":174
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:183"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":183
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:184"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":184
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:185"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":185
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:186"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":186
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:187"
                    , "data":
                    [25.6923, 224.615, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":187
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:188"
                    , "data":
                    [25.8182, 224.727, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":188
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:189"
                    , "data":
                    [25.8182, 224.727, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":189
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:190"
                    , "data":
                    [25.8182, 224.727, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":190
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:204"
                    , "data":
                    [634.333, 1069.17, 9.5, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":204
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:213"
                    , "data":
                    [25.8182, 224.727, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":213
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:214"
                    , "data":
                    [25.8182, 224.727, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":214
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:215"
                    , "data":
                    [25.8182, 224.727, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":215
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:216"
                    , "data":
                    [25.8182, 224.727, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":216
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:217"
                    , "data":
                    [25.8182, 224.727, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":217
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:218"
                    , "data":
                    [25.8182, 224.727, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":218
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:219"
                    , "data":
                    [25.8182, 224.727, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":219
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:220"
                    , "data":
                    [25.8182, 224.727, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":220
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:234"
                    , "data":
                    [605, 1017.17, 10.8333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":234
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:79"
                    , "data":
                    [4.66667, 3, 0.333333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":79
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:87"
                    , "data":
                    [105.583, 2261.58, 2.66667, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":87
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:89"
                    , "data":
                    [21, 21.5, 0.5, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":89
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:90"
                    , "data":
                    [16, 32, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":90
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:92"
                    , "data":
                    [16, 32, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":92
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:93"
                    , "data":
                    [51, 40.5, 1.5, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":93
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:96"
                    , "data":
                    [95.0667, 169.133, 0.666667, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":96
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [1627.95, 5507.48, 7.66667, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Feedback"
              , "data":
              [65, 53, 2, 0]
              , "details":
              [
                "Resources for loop-carried dependencies. To reduce this area:\n- reduce number and size of loop-carried variables"
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:87"
                    , "data":
                    [25, 19, 1, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":87
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [40, 34, 1, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Cluster logic"
              , "data":
              [1485, 2850, 7, 0]
              , "details":
              [
                "Logic required to efficiently support sets of operations that do not stall. This area cannot be affected directly."
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"No Source Line"
              , "data":
              [63, 28, 0, 0]
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
                    "name":"Floating Point Compare"
                    , "data":
                    [63, 28, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:87"
              , "data":
              [4, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":87
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
                    [4, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:89"
              , "data":
              [1285, 660, 13, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":89
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [1285, 660, 13, 0]
                    , "details":
                    [
                      "Load with a private 128 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:90"
              , "data":
              [9, 8, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":90
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [9, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_InterE.cl:29."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:91"
              , "data":
              [9, 8, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":91
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [9, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_InterE.cl:30."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:92"
              , "data":
              [9, 8, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":92
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [9, 8, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_InterE.cl:31."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:93"
              , "data":
              [421, 663, 13, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":93
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [421, 663, 13, 0]
                    , "details":
                    [
                      "Load with a private 256 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:96"
              , "data":
              [315, 140, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":96
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Floating Point Compare"
                    , "data":
                    [315, 140, 0, 0]
                  }
                  , "count":5
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:105"
              , "data":
              [350, 351, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":105
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'__acl__convert_FPtoSI_32' Function Call"
                    , "data":
                    [175, 187, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"'floorf' Function Call"
                    , "data":
                    [175, 164, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:106"
              , "data":
              [350, 351, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":106
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'__acl__convert_FPtoSI_32' Function Call"
                    , "data":
                    [175, 187, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"'floorf' Function Call"
                    , "data":
                    [175, 164, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:107"
              , "data":
              [350, 351, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":107
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'__acl__convert_FPtoSI_32' Function Call"
                    , "data":
                    [175, 187, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"'floorf' Function Call"
                    , "data":
                    [175, 164, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:108"
              , "data":
              [349, 344, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":108
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'__acl__convert_FPtoSI_32' Function Call"
                    , "data":
                    [175, 187, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"'ceilf' Function Call"
                    , "data":
                    [174, 157, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:109"
              , "data":
              [349, 344, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":109
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'__acl__convert_FPtoSI_32' Function Call"
                    , "data":
                    [175, 187, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"'ceilf' Function Call"
                    , "data":
                    [174, 157, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:110"
              , "data":
              [349, 344, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":110
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'__acl__convert_FPtoSI_32' Function Call"
                    , "data":
                    [175, 187, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"'ceilf' Function Call"
                    , "data":
                    [174, 157, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:111"
              , "data":
              [516, 771, 0, 3]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":111
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 3]
                  }
                  , "count":3
                }
                , {
                  "info":
                  {
                    "name":"Integer to Floating Point Conversion"
                    , "data":
                    [516, 771, 0, 0]
                  }
                  , "count":3
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:115"
              , "data":
              [0, 0, 0, 5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":115
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":2
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 3]
                  }
                  , "count":3
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:116"
              , "data":
              [0, 0, 0, 2]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":116
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:117"
              , "data":
              [0, 0, 0, 2]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":117
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:118"
              , "data":
              [0, 0, 0, 2]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":118
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:119"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":119
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:120"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":120
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:121"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":121
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:122"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":122
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:140"
              , "data":
              [0, 64, 0, 2]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":140
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Mul"
                    , "data":
                    [0, 64, 0, 2]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:141"
              , "data":
              [0, 64, 0, 4]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":141
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Mul"
                    , "data":
                    [0, 64, 0, 4]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:142"
              , "data":
              [32, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":142
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [32, 0, 0, 0]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:143"
              , "data":
              [32, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":143
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [32, 0, 0, 0]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:144"
              , "data":
              [32, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":144
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [32, 0, 0, 0]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:145"
              , "data":
              [32, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":145
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [32, 0, 0, 0]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:146"
              , "data":
              [16, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":146
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:147"
              , "data":
              [16, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":147
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:148"
              , "data":
              [16, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":148
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:149"
              , "data":
              [16, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":149
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:150"
              , "data":
              [0, 32, 0, 2]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":150
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Mul"
                    , "data":
                    [0, 32, 0, 2]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:153"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":153
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:154"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":154
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:155"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":155
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:156"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":156
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:157"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":157
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:158"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":158
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:159"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":159
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:160"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":160
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:174"
              , "data":
              [0, 0, 0, 9]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":174
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 8]
                  }
                  , "count":4
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:183"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":183
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:184"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":184
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:185"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":185
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:186"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":186
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:187"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":187
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:188"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":188
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:189"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":189
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:190"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":190
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:204"
              , "data":
              [0, 0, 0, 9]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":204
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 8]
                  }
                  , "count":4
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply-Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:213"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":213
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:214"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":214
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:215"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":215
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:216"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":216
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:217"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":217
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:218"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":218
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:219"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":219
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:220"
              , "data":
              [3053, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":220
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Pointer Computation"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_InterE.cl:234"
              , "data":
              [0, 0, 0, 10]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                    , "line":234
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 8]
                  }
                  , "count":4
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
        , {
          "name":"Block16"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [0, 16, 0, 0]
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
                    [0, 16, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
          ]
        }
        , {
          "name":"Block17"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [344, 688, 0, 0]
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
                    [320, 480, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:55"
                    , "data":
                    [12, 197, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":55
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_InterE.cl:77"
                    , "data":
                    [12, 11, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl"
                          , "line":77
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
          ]
        }
      ]
    }
    , {
      "name":"Krnl_IntraE"
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
          [1570, 1685, 0, 0]
          , "details":
          [
            "Kernel dispatch logic."
          ]
        }
        , {
          "name":"Krnl_IntraE.cl:16 (loc_coords_x)"
          , "data":
          [33, 256, 2, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                , "line":16
              }
            ]
          ]
          , "details":
          [
            "Local memory: Optimal.\nRequested size 512 bytes (rounded up to nearest power of 2), implemented size 512 bytes, stall-free, 2 reads and 1 write. Additional information:\n- Reducing accesses to exactly one read and one write for all on-chip memory systems may increase overall system performance."
          ]
        }
        , {
          "name":"Krnl_IntraE.cl:17 (loc_coords_y)"
          , "data":
          [33, 256, 2, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                , "line":17
              }
            ]
          ]
          , "details":
          [
            "Local memory: Optimal.\nRequested size 512 bytes (rounded up to nearest power of 2), implemented size 512 bytes, stall-free, 2 reads and 1 write. Additional information:\n- Reducing accesses to exactly one read and one write for all on-chip memory systems may increase overall system performance."
          ]
        }
        , {
          "name":"Krnl_IntraE.cl:18 (loc_coords_z)"
          , "data":
          [33, 256, 2, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                , "line":18
              }
            ]
          ]
          , "details":
          [
            "Local memory: Optimal.\nRequested size 512 bytes (rounded up to nearest power of 2), implemented size 512 bytes, stall-free, 2 reads and 1 write. Additional information:\n- Reducing accesses to exactly one read and one write for all on-chip memory systems may increase overall system performance."
          ]
        }
        , {
          "name":"Private Variable: \n - 'contributor_counter' (Krnl_IntraE.cl:65)"
          , "data":
          [40, 34, 1, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                , "line":65
              }
            ]
          ]
          , "details":
          [
            "Implemented using registers of the following size:\n- 1 register of width 32 and depth 17 (depth was increased by a factor of 17 due to a loop initiation interval of 17.)\nReducing the scope of the variable may reduce its depth (e.g. moving declaration inside a loop or using it as soon as possible)."
          ]
        }
        , {
          "name":"Private Variable: \n - 'intraE' (Krnl_IntraE.cl:32)"
          , "data":
          [72, 130, 1, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                , "line":32
              }
            ]
          ]
          , "details":
          [
            "Implemented using registers of the following size:\n- 1 register of width 32 and depth 17 (depth was increased by a factor of 17 due to a loop initiation interval of 17.)\nReducing the scope of the variable may reduce its depth (e.g. moving declaration inside a loop or using it as soon as possible)."
          ]
        }
        , {
          "name":"Private Variable: \n - 'pipe_cnt' (Krnl_IntraE.cl:40)"
          , "data":
          [24, 101, 0, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                , "line":40
              }
            ]
          ]
          , "details":
          [
            "Implemented using registers of the following size:\n- 1 register of width 32 and depth 1"
          ]
        }
      ]
      , "basicblocks":
      [
        {
          "name":"Block18.wii_blk"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [476, 476, 0, 0]
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
                    "name":"Krnl_IntraE.cl:101"
                    , "data":
                    [42.6667, 42.6667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":101
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:109"
                    , "data":
                    [42.6667, 42.6667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":109
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:112"
                    , "data":
                    [62, 62, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":112
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:114"
                    , "data":
                    [42.6667, 42.6667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":114
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:40"
                    , "data":
                    [50.6667, 50.6667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":40
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:65"
                    , "data":
                    [58.6667, 58.6667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":65
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:73"
                    , "data":
                    [42.6667, 42.6667, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":73
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [102, 102, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_IntraE.cl:40"
              , "data":
              [0.333333, 43, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":40
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [0.333333, 43, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:65"
              , "data":
              [0.333333, 43, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":65
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [0.333333, 43, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:73"
              , "data":
              [0.333333, 43, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":73
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [0.333333, 43, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:101"
              , "data":
              [0.333333, 43, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":101
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [0.333333, 43, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:109"
              , "data":
              [0.333333, 43, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":109
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [0.333333, 43, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:112"
              , "data":
              [16, 48, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":112
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [16, 48, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:114"
              , "data":
              [0.333333, 43, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":114
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [0.333333, 43, 0, 0]
                    , "details":
                    [
                      "Work-Item Invariant instruction."
                    ]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
        , {
          "name":"Block19"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [33, 357, 0, 0]
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
                    [33, 309, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:20"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":20
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:21"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":21
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:22"
                    , "data":
                    [0, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":22
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:47"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":47
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:49"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":49
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:51"
                    , "data":
                    [0, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":51
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
          ]
        }
        , {
          "name":"Block20"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [478, 1041, 1, 0]
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
                    [33, 81, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:40"
                    , "data":
                    [26, 107.333, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":40
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:41"
                    , "data":
                    [32.4583, 30.7778, 0.222222, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":41
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:43"
                    , "data":
                    [43.4405, 118.183, 0.222222, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":43
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:45"
                    , "data":
                    [62.1905, 290.116, 0.222222, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":45
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:47"
                    , "data":
                    [15.3036, 21.3079, 0.111111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":47
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:48"
                    , "data":
                    [106, 82, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":48
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:49"
                    , "data":
                    [19.8036, 25.3079, 0.111111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":49
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:51"
                    , "data":
                    [27.8036, 56.3079, 0.111111, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":51
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [112, 228.667, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Feedback"
              , "data":
              [15, 75, 0, 0]
              , "details":
              [
                "Resources for loop-carried dependencies. To reduce this area:\n- reduce number and size of loop-carried variables"
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:40"
                    , "data":
                    [7, 6, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":40
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [8, 69, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Cluster logic"
              , "data":
              [218, 502, 2, 0]
              , "details":
              [
                "Logic required to efficiently support sets of operations that do not stall. This area cannot be affected directly."
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_IntraE.cl:40"
              , "data":
              [16, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":40
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
              "name":"Krnl_IntraE.cl:41"
              , "data":
              [34, 24, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":41
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
                    [34, 24, 0, 0]
                    , "details":
                    [
                      "Stall-free write to memory declared on Krnl_IntraE.cl:16."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:43"
              , "data":
              [34, 24, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":43
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
                    [34, 24, 0, 0]
                    , "details":
                    [
                      "Stall-free write to memory declared on Krnl_IntraE.cl:17."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:45"
              , "data":
              [34, 24, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":45
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
                    [34, 24, 0, 0]
                    , "details":
                    [
                      "Stall-free write to memory declared on Krnl_IntraE.cl:18."
                    ]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
        , {
          "name":"Block21"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [126, 482, 0, 0]
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
                    [32, 48, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:20"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":20
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:21"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":21
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:22"
                    , "data":
                    [0, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":22
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:47"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":47
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:49"
                    , "data":
                    [0, 4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":49
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:51"
                    , "data":
                    [0, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":51
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:56"
                    , "data":
                    [54, 337, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":56
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [40, 49, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_IntraE.cl:56"
              , "data":
              [1535, 3793, 16, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":56
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
        , {
          "name":"Block22"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [2945, 7615, 38, 0]
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
                    [33, 193, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:101"
                    , "data":
                    [74.9481, 122.948, 1.14286, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":101
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:103"
                    , "data":
                    [20.9481, 35.9481, 0.142857, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":103
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:104"
                    , "data":
                    [82.9481, 138.948, 1.14286, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":104
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:106"
                    , "data":
                    [32, 64, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":106
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:109"
                    , "data":
                    [429.62, 1162.56, 3.16667, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":109
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:112"
                    , "data":
                    [82.9481, 122.948, 0.142857, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":112
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:113"
                    , "data":
                    [181.896, 252.896, 0.285714, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":113
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:114"
                    , "data":
                    [272.948, 456.948, 1.14286, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":114
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:115"
                    , "data":
                    [183.105, 336.209, 2.33333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":115
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:58"
                    , "data":
                    [48, 73, 2, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":58
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:65"
                    , "data":
                    [165.533, 901.033, 8.25, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":65
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:67"
                    , "data":
                    [38.3333, 56.1667, 0.5, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":67
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:68"
                    , "data":
                    [17, 13.5, 0.5, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":68
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:70"
                    , "data":
                    [32, 64, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":70
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:71"
                    , "data":
                    [32, 64, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":71
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:72"
                    , "data":
                    [96, 192, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":72
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:73"
                    , "data":
                    [80, 160, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":73
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:75"
                    , "data":
                    [48, 96, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":75
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:88"
                    , "data":
                    [16, 32, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":88
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:89"
                    , "data":
                    [8, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":89
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:90"
                    , "data":
                    [64, 128, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":90
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:92"
                    , "data":
                    [8, 16, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":92
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:95"
                    , "data":
                    [26.3048, 45.6095, 0.333333, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":95
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:97"
                    , "data":
                    [80.0909, 328.591, 1, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":97
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:98"
                    , "data":
                    [80.0909, 328.591, 1, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":98
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [711.286, 2214.1, 14.9167, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Feedback"
              , "data":
              [65, 53, 2, 0]
              , "details":
              [
                "Resources for loop-carried dependencies. To reduce this area:\n- reduce number and size of loop-carried variables"
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:65"
                    , "data":
                    [25, 19, 1, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":65
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [40, 34, 1, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Cluster logic"
              , "data":
              [1956, 4388, 19, 0]
              , "details":
              [
                "Logic required to efficiently support sets of operations that do not stall. This area cannot be affected directly."
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"No Source Line"
              , "data":
              [0, 0, 0, 1]
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
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:65"
              , "data":
              [26, 0, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":65
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [10, 0, 0, 0]
                  }
                  , "count":3
                }
                , {
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
              "name":"Krnl_IntraE.cl:67"
              , "data":
              [1722, 1715.5, 21.5, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":67
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [5, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [1717, 1715.5, 21.5, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:68"
              , "data":
              [1717, 1715.5, 21.5, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":68
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [1717, 1715.5, 21.5, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:70"
              , "data":
              [18, 16, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":70
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [18, 16, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_IntraE.cl:16."
                    ]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:71"
              , "data":
              [18, 16, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":71
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [18, 16, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_IntraE.cl:17."
                    ]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:72"
              , "data":
              [18, 16, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":72
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [18, 16, 0, 0]
                    , "details":
                    [
                      "Stall-free read from memory declared on Krnl_IntraE.cl:18."
                    ]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:73"
              , "data":
              [129, 346, 3, 6]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":73
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'sqrtf' Function Call"
                    , "data":
                    [129, 346, 3, 2]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply-Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:75"
              , "data":
              [63, 28, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":75
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Floating Point Compare"
                    , "data":
                    [63, 28, 0, 0]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:88"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":88
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:89"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":89
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:90"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":90
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:92"
              , "data":
              [0, 0, 0, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":92
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:95"
              , "data":
              [126, 56, 0, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":95
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Floating Point Compare"
                    , "data":
                    [126, 56, 0, 0]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:97"
              , "data":
              [3165, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":97
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3165, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:98"
              , "data":
              [3165, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":98
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3165, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:101"
              , "data":
              [3222, 4707, 48, 8]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":101
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Add"
                    , "data":
                    [16, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Floating Point Divide"
                    , "data":
                    [185, 409, 5, 5]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Mul"
                    , "data":
                    [0, 32, 0, 2]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:103"
              , "data":
              [3165, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":103
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3165, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:104"
              , "data":
              [3206, 4675, 48, 5.5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":104
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Floating Point Divide"
                    , "data":
                    [185, 409, 5, 5]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 0.5]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:106"
              , "data":
              [0, 0, 0, 0.5]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":106
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Sub"
                    , "data":
                    [0, 0, 0, 0.5]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:109"
              , "data":
              [6688, 9561, 99, 24]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":109
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'expf' Function Call"
                    , "data":
                    [276, 211, 3, 6]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Floating Point Divide"
                    , "data":
                    [370, 818, 10, 10]
                  }
                  , "count":2
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Add"
                    , "data":
                    [0, 0, 0, 3]
                  }
                  , "count":3
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 5]
                  }
                  , "count":5
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [6042, 8532, 86, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:112"
              , "data":
              [3021, 4266, 43, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":112
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:113"
              , "data":
              [6042, 8532, 86, 1]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":113
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply-Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [6042, 8532, 86, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":2
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:114"
              , "data":
              [3021, 4266, 43, 4]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":114
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Hardened Floating-Point Dot Product of Size 2"
                    , "data":
                    [0, 0, 0, 2]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply-Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Load"
                    , "data":
                    [3021, 4266, 43, 0]
                    , "details":
                    [
                      "Load with a private 512 kilobit cache. Cache is not shared with any other load. It is flushed on kernel start. Use Dynamic Profiler to verify cache effectiveness. Other kernels should not be updating the data in global memory while this kernel is using it. Cache is created when memory access pattern is data-dependent or appears to be repetitive. Simplify access pattern or mark pointer as 'volatile' to disable generation of this cache."
                    ]
                  }
                  , "count":1
                }
              ]
            }
            , {
              "name":"Krnl_IntraE.cl:115"
              , "data":
              [461, 620, 8, 13]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                    , "line":115
                  }
                ]
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"'expf' Function Call"
                    , "data":
                    [276, 211, 3, 6]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Floating Point Divide"
                    , "data":
                    [185, 409, 5, 5]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
                , {
                  "info":
                  {
                    "name":"Hardened Floating-Point Multiply-Add"
                    , "data":
                    [0, 0, 0, 1]
                  }
                  , "count":1
                }
              ]
            }
          ]
        }
        , {
          "name":"Block23"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [280, 592, 0, 0]
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
                    [256, 384, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:34"
                    , "data":
                    [12, 197, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":34
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_IntraE.cl:56"
                    , "data":
                    [12, 11, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl"
                          , "line":56
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
          ]
        }
        , {
          "name":"Block24"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [0, 16, 0, 0]
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
                    [0, 16, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
          ]
        }
      ]
    }
    , {
      "name":"Krnl_Store"
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
          [1570, 1685, 0, 0]
          , "details":
          [
            "Kernel dispatch logic."
          ]
        }
        , {
          "name":"Private Variable: \n - 'active' (Krnl_Store.cl:20)"
          , "data":
          [7, 33.6667, 0, 0]
          , "debug":
          [
            [
              {
                "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                , "line":20
              }
            ]
          ]
          , "details":
          [
            "Implemented using registers of the following size:\n- 1 register of width 8 and depth 2\nReducing the scope of the variable may reduce its depth (e.g. moving declaration inside a loop or using it as soon as possible)."
          ]
        }
      ]
      , "basicblocks":
      [
        {
          "name":"Block25"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [32, 32, 0, 0]
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
              ]
            }
          ]
          , "computation":
          [
          ]
        }
        , {
          "name":"Block26"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [461.5, 2007.5, 1, 0]
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
                    [33, 81, 0, 0]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:20"
                    , "data":
                    [10.75, 10.75, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":20
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:30"
                    , "data":
                    [86.15, 398.15, 1, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":30
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:35"
                    , "data":
                    [10.75, 10.75, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":35
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:40"
                    , "data":
                    [8, 8, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":40
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:41"
                    , "data":
                    [1.5, 1.33333, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":41
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:42"
                    , "data":
                    [1.5, 1.33333, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":42
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:46"
                    , "data":
                    [59.4, 341.4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":46
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:47"
                    , "data":
                    [10.75, 10.75, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":47
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:49"
                    , "data":
                    [68.4, 350.4, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":49
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:52"
                    , "data":
                    [64.9, 392.9, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":52
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:55"
                    , "data":
                    [59.9, 341.9, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":55
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [46.5, 58.8333, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Feedback"
              , "data":
              [45, 157.333, 0, 0]
              , "details":
              [
                "Resources for loop-carried dependencies. To reduce this area:\n- reduce number and size of loop-carried variables"
              ]
              , "subinfos":
              [
                {
                  "info":
                  {
                    "name":"Krnl_Store.cl:20"
                    , "data":
                    [4.66667, 22.4444, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":20
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:30"
                    , "data":
                    [10, 9, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":30
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:35"
                    , "data":
                    [4.66667, 22.4444, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":35
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:47"
                    , "data":
                    [4.66667, 22.4444, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":47
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"Krnl_Store.cl:55"
                    , "data":
                    [13, 12, 0, 0]
                    , "debug":
                    [
                      [
                        {
                          "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                          , "line":55
                        }
                      ]
                    ]
                  }
                  , "count":0
                }
                , {
                  "info":
                  {
                    "name":"No Source Line"
                    , "data":
                    [8, 69, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
            , {
              "name":"Cluster logic"
              , "data":
              [234.5, 578.5, 2, 0]
              , "details":
              [
                "Logic required to efficiently support sets of operations that do not stall. This area cannot be affected directly."
              ]
            }
          ]
          , "computation":
          [
            {
              "name":"Krnl_Store.cl:46"
              , "data":
              [1539, 3793, 16, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                    , "line":46
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
                    [4, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
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
            , {
              "name":"Krnl_Store.cl:49"
              , "data":
              [1539, 3793, 16, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                    , "line":49
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
                    [4, 0, 0, 0]
                  }
                  , "count":1
                }
                , {
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
            , {
              "name":"Krnl_Store.cl:52"
              , "data":
              [1551, 3793, 16, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                    , "line":52
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
                , {
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
            , {
              "name":"Krnl_Store.cl:55"
              , "data":
              [1535, 3793, 16, 0]
              , "debug":
              [
                [
                  {
                    "filename":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl"
                    , "line":55
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
        , {
          "name":"Block27"
          , "resources":
          [
            {
              "name":"State"
              , "data":
              [0, 16, 0, 0]
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
                    [0, 16, 0, 0]
                  }
                  , "count":0
                }
              ]
            }
          ]
          , "computation":
          [
          ]
        }
      ]
    }
  ]
}
;var fileJSON=[{"index":0, "path":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_GA.cl", "name":"Krnl_GA.cl", "content":"// Enable the channels extension\012#pragma OPENCL EXTENSION cl_altera_channels : enable\012\012// Define kernel file-scope channel variable\012// Buffered channels \012// MAX_NUM_OF_ATOMS=90\012// ACTUAL_GENOTYPE_LENGTH (MAX_NUM_OF_ROTBONDS+6) =38\012channel float chan_GA2Conf_genotype __attribute__((depth(38)));\012//channel char  chan_GA2Manager_mode;	// mode 1 or I: init calculation energy, 2 or G: genetic generation, 3 or P: local search\012//channel uint  chan_GA2Manager_cnt;	// population count\012channel char  chan_GA2Conf_active;	// active 1: receiving Kernel is active, 0 receiving Kernel is disabled\012channel char  chan_GA2Conf_mode;	// mode 1 or I: init calculation energy, 2 or G: genetic generation, 3 or P: local search\012channel uint  chan_GA2Conf_cnt;		// population count\012\012channel float chan_Conf2Intere_x __attribute__((depth(90)));\012channel float chan_Conf2Intere_y __attribute__((depth(90)));\012channel float chan_Conf2Intere_z __attribute__((depth(90)));\012channel char  chan_Conf2Intere_active;	\012channel char  chan_Conf2Intere_mode;	\012channel uint  chan_Conf2Intere_cnt;	\012\012channel float chan_Conf2Intrae_x __attribute__((depth(90)));\012channel float chan_Conf2Intrae_y __attribute__((depth(90)));\012channel float chan_Conf2Intrae_z __attribute__((depth(90)));\012channel char  chan_Conf2Intrae_active;	\012channel char  chan_Conf2Intrae_mode;	\012channel uint  chan_Conf2Intrae_cnt;\012\012channel float chan_Intere2Store_intere;\012channel char  chan_Intere2Store_active;	\012channel char  chan_Intere2Store_mode;	\012channel uint  chan_Intere2Store_cnt;\012\012channel float chan_Intrae2Store_intrae;\012channel char  chan_Intrae2Store_active;	\012channel char  chan_Intrae2Store_mode;	\012channel uint  chan_Intrae2Store_cnt;\012\012channel char  chan_Store2GA_ack;\012channel float chan_Store2GA_LSenergy;\012\012#include \"../defines.h\"\012\012// Next structures were copied from calcenergy.h\012typedef struct\012{\012	char  	 	num_of_atoms;\012	char   		num_of_atypes;\012	int    		num_of_intraE_contributors;\012	char   		gridsize_x;\012	char   		gridsize_y;\012	char   		gridsize_z;\012	float  		grid_spacing;\012/*\012	float* 		fgrids;\012*/\012	int    		rotbondlist_length;\012	float  		coeff_elec;\012	float  		coeff_desolv;\012/*\012	float* 		conformations_current;\012	float* 		energies_current;\012	float* 		conformations_next;\012	float* 		energies_next;\012	int*   		evals_of_new_entities;\012	unsigned int* 	prng_states;\012*/\012\012	// L30nardoSV added\012	unsigned int num_of_energy_evals;\012	unsigned int num_of_generations;\012\012	int    		pop_size;\012	int    		num_of_genes;\012	float  		tournament_rate;\012	float  		crossover_rate;\012	float  		mutation_rate;\012	float  		abs_max_dmov;\012	float  		abs_max_dang;\012	float  		lsearch_rate;\012	unsigned int 	num_of_lsentities;\012	float  		rho_lower_bound;\012	float  		base_dmov_mul_sqrt3;\012	float  		base_dang_mul_sqrt3;\012	unsigned int 	cons_limit;\012	unsigned int 	max_num_of_iters;\012	float  		qasp;\012} Dockparameters;\012\012// Constant struct\012typedef struct\012{\012       float atom_charges_const[MAX_NUM_OF_ATOMS];\012       char  atom_types_const  [MAX_NUM_OF_ATOMS];\012       char  intraE_contributors_const[3*MAX_INTRAE_CONTRIBUTORS];\012       float VWpars_AC_const   [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES];\012       float VWpars_BD_const   [MAX_NUM_OF_ATYPES*MAX_NUM_OF_ATYPES];\012       float dspars_S_const    [MAX_NUM_OF_ATYPES];\012       float dspars_V_const    [MAX_NUM_OF_ATYPES];\012       int   rotlist_const     [MAX_NUM_OF_ROTATIONS];\012       float ref_coords_x_const[MAX_NUM_OF_ATOMS];\012       float ref_coords_y_const[MAX_NUM_OF_ATOMS];\012       float ref_coords_z_const[MAX_NUM_OF_ATOMS];\012       float rotbonds_moving_vectors_const[3*MAX_NUM_OF_ROTBONDS];\012       float rotbonds_unit_vectors_const  [3*MAX_NUM_OF_ROTBONDS];\012       //float ref_orientation_quats_const  [4*MAX_NUM_OF_RUNS];\012       float ref_orientation_quats_const  [4];\012} kernelconstant;\012\012\012#include \"auxiliary_genetic.cl\"\012#include \"auxiliary_performls.cl\"\012\012\012// --------------------------------------------------------------------------\012// The function performs a generational genetic algorithm based search \012// on the search space.\012// The first parameter is the population which must be filled with initial values \012// before calling this function. \012// The other parameters are variables which describe the grids, \012// the docking parameters and the ligand to be docked. \012// Originally from: searchoptimum.c\012// --------------------------------------------------------------------------\012__kernel\012void Krnl_GA(//__global const float*           restrict GlobFgrids,\012	     __global       float*           restrict GlobPopulationCurrent,\012	     __global       float*           restrict GlobEnergyCurrent,\012	     __global       float*           restrict GlobPopulationNext,\012	     __global       float*           restrict GlobEnergyNext,\012             __global       unsigned int*    restrict GlobPRNG,\012	     __global const kernelconstant*  restrict KerConst,\012	     __global const Dockparameters*  restrict DockConst,\012	     __global       unsigned int*    restrict GlobEvals_performed,\012	     __global       unsigned int*    restrict GlobGenerations_performed)\012{\012	//Print algorithm parameters\012\012	#if defined (DEBUG_KERNEL1)\012	printf(\"\\nParameters of the genetic algorihtm:\\n\");\012	printf(\"\\nLigand num_of_atoms: %u\\n\",  DockConst->num_of_atoms);\012	printf(\"Ligand num_of_atypes:  %u\\n\",  DockConst->num_of_atypes);\012	printf(\"Ligand num_of_intraE_contributors: %u\\n\",  DockConst->num_of_atypes);\012	printf(\"Grid size_x: %u\\n\", 		DockConst->gridsize_x);\012	printf(\"Grid size_y: %u\\n\",   		DockConst->gridsize_y);\012	printf(\"Grid size_z: %u\\n\",   		DockConst->gridsize_z);\012	printf(\"Grid spacing: %f\\n\",  		DockConst->grid_spacing);\012	printf(\"Ligand rotbondlist_length: %u\\n\",  DockConst->rotbondlist_length);\012	printf(\"Ligand coeff_elec: %f\\n\",  	DockConst->coeff_elec);\012	printf(\"Ligand coeff_desolv: %f\\n\",  	DockConst->coeff_desolv);\012	printf(\"\\nnum_of_energy_evals: %u\\n\",   DockConst->num_of_energy_evals);\012	printf(\"num_of_generations: %u\\n\",   	DockConst->num_of_generations);\012	printf(\"Population size: %u\\n\",         DockConst->pop_size);\012	printf(\"Number of genes: %u\\n\",         DockConst->num_of_genes);\012	printf(\"Tournament rate: %f\\n\",  	DockConst->tournament_rate);\012	printf(\"Crossover rate: %f\\n\",  	DockConst->crossover_rate);\012	printf(\"Mutation rate: %f\\n\",  		DockConst->mutation_rate);\012	printf(\"Maximal delta movement during mutation: +/-%fA\\n\", DockConst->abs_max_dmov);\012	printf(\"maximal delta angle during mutation: +/-%f°\\n\",    DockConst->abs_max_dang);\012	printf(\"LS rate: %f\\n\",  		DockConst->lsearch_rate);\012	printf(\"LS num_of_lsentities: %u\\n\",    DockConst->num_of_lsentities);\012	printf(\"LS rho_lower_bound: %f\\n\",      DockConst->rho_lower_bound);	 //Rho lower bound\012	printf(\"LS base_dmov_mul_sqrt3: %f\\n\",  DockConst->base_dmov_mul_sqrt3); //Maximal delta movement during ls\012	printf(\"LS base_dang_mul_sqrt3: %f\\n\",  DockConst->base_dang_mul_sqrt3); //Maximal delta angle during ls\012	printf(\"LS cons_limit: %u\\n\",           DockConst->cons_limit);\012	printf(\"LS max_num_of_iters: %u\\n\",     DockConst->max_num_of_iters);\012	printf(\"qasp: %f\\n\",     DockConst->qasp);\012	#endif\012\012\012\012\012\012\012\012	//Calculating energies of initial population\012	uint eval_cnt = 0;\012	uint generation_cnt = 1;\012	uint pop_cnt;\012	uint new_pop_cnt;\012\012	char active = 0;\012	char mode   = 0;\012	char ack    = 0;\012\012\012\012\012\012\012\012\012/*\012\012\012\012\012\012\012\012\012\012	LOOP_GEN_GENERATIONAL_1:\012	for (pop_cnt = 0; pop_cnt < DockConst->pop_size; pop_cnt++)\012	{	\012		// --------------------------------------------------------------\012		// Send genotypes to channel\012		// --------------------------------------------------------------\012		for (uint pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {\012			write_channel_altera(chan_GA2Conf_genotype, GlobPopulationCurrent[pop_cnt*ACTUAL_GENOTYPE_LENGTH+ pipe_cnt]);\012		}\012		active = 1;\012		mode   = 1;\012		write_channel_altera(chan_GA2Conf_active, active);\012		write_channel_altera(chan_GA2Conf_mode,   mode);\012		write_channel_altera(chan_GA2Conf_cnt,    pop_cnt);\012		// --------------------------------------------------------------\012		\012		#if defined (DEBUG_LEO)\012		printf(\"pop_cnt (INC): %u\\n\", pop_cnt);\012		#endif\012	} // End of LOOP_GEN_GENERATIONAL_1\012	\012	eval_cnt = pop_cnt++;\012	\012	#if defined (DEBUG_LEO)\012	printf(\"eval_cnt (INC): %u\\n\", eval_cnt);\012	#endif\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012	// --------------------------------------------------------------\012	// Send DUMMY genotypes to channel to signal INI stop\012	// --------------------------------------------------------------\012	for (uint pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {\012		write_channel_altera(chan_GA2Conf_genotype, 0);\012	}\012	active = 1;\012	mode   = 0;\012	write_channel_altera(chan_GA2Conf_active, active);\012	write_channel_altera(chan_GA2Conf_mode,   mode);\012	write_channel_altera(chan_GA2Conf_cnt,    0);\012\012	ack = read_channel_altera(chan_Store2GA_ack);\012	//printf(\"INI ack: %u\\n\", ack);\012	// --------------------------------------------------------------\012		\012\012\012\012\012\012\012\012\012\012\012\012	// Find_best\012	uint best_entity_id;\012	__local float loc_energies[MAX_POPSIZE];\012\012	// Binary tournament\012	uint parent1, parent2;\012	__local float local_entity_1     [ACTUAL_GENOTYPE_LENGTH];\012	__local float local_entity_2     [ACTUAL_GENOTYPE_LENGTH];	\012	__local float offspring_genotype [ACTUAL_GENOTYPE_LENGTH];\012\012	// local search\012	uint entity_for_ls;\012	uint LS_eval;\012	uint evals_for_ls_in_this_cycle;\012	uint num_of_evals_for_ls  = 0;\012	__local float local_entity_ls	 [ACTUAL_GENOTYPE_LENGTH];\012	__local float entity_possible_new_genotype [ACTUAL_GENOTYPE_LENGTH];\012	float local_entity_energy;\012\012\012\012	// **********************************************\012	// ADD VENDOR SPECIFIC PRAGMA\012	// **********************************************\012	float avg_energy;\012	\012	LOOP_WHILE_GEN_GENERATIONAL_1:\012	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\012	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\012	while ((eval_cnt < DockConst->num_of_energy_evals) && (generation_cnt < DockConst->num_of_generations))\012	{\012		//Creating a new population\012\012		//Identifying best entity\012		best_entity_id = find_best(GlobEnergyCurrent, loc_energies, DockConst->pop_size); \012\012		#if defined (DEBUG_KERNEL1)\012		avg_energy = 0.0f;\012		printf(\"\\n\\n\\nFinal state of the %u. generation:\\n\", generation_cnt);\012		printf(\"----------------------------\\n\\n\");\012		for (i=0; i<DockConst->pop_size; i++)\012		{\012			avg_energy += GlobEnergyCurrent [i];\012			printf(\"Entity %3u: \", i);\012			for (j=0; j<ACTUAL_GENOTYPE_LENGTH; j++) {\012				printf(\"%8.3f \", GlobPopulationCurrent [i*ACTUAL_GENOTYPE_LENGTH +j]);\012			}\012			printf(\"   energy sum: %10.3f\\n\", GlobEnergyCurrent [i*40 + 38]);\012		}\012		printf(\"\\nAverage energy: %f\\nBest energy sum: %f)\\n\\n\", avg_energy/DockConst->pop_size, \012		      GlobEnergyCurrent[best_entity_id]);\012		#endif\012\012		//elitism - copying the best entity to new population\012		for (uint i=0; i<ACTUAL_GENOTYPE_LENGTH; i++)\012		{\012			GlobPopulationNext[i] = GlobPopulationCurrent[best_entity_id*ACTUAL_GENOTYPE_LENGTH+i];\012		}\012		GlobEnergyNext[best_entity_id] = GlobEnergyCurrent[best_entity_id];\012\012\012		//new population consists of one member currently\012		new_pop_cnt = 1;\012\012\012\012\012\012\012\012		// -----------------------------------------------------------------------\012		// **********************************************\012		// ADD VENDOR SPECIFIC PRAGMA\012		// **********************************************\012		LOOP_GEN_GENERATIONAL_2:\012		for (new_pop_cnt = 1; new_pop_cnt < DockConst->pop_size; new_pop_cnt++)\012		{\012			//printf(\"BEFORE BINARY TOURNAMENT, %u\\n\",new_pop_cnt);\012			//selecting two individuals randomly\012			binary_tournament_selection(GlobEnergyCurrent,\012						    GlobPRNG,\012						    &parent1,\012						    &parent2,\012						    DockConst->pop_size,\012						    DockConst->tournament_rate);\012			//printf(\"AFTER BINARY TOURNAMENT, %u\\n\",new_pop_cnt);\012\012\012			//mating parents	\012			async_work_group_copy(local_entity_1, GlobPopulationCurrent+parent1*ACTUAL_GENOTYPE_LENGTH, ACTUAL_GENOTYPE_LENGTH, 0);\012			async_work_group_copy(local_entity_2, GlobPopulationCurrent+parent2*ACTUAL_GENOTYPE_LENGTH, ACTUAL_GENOTYPE_LENGTH, 0);\012\012\012			//printf(\"BEFORE GEN NEW GENOTYPE, %u\\n\",new_pop_cnt);\012			// first two args are population [parent1], population [parent2]\012			gen_new_genotype(GlobPRNG,\012                                         local_entity_1, \012					 local_entity_2,\012					 DockConst->mutation_rate,\012					 DockConst->abs_max_dmov,\012					 DockConst->abs_max_dang,\012					 DockConst->crossover_rate,\012					 ACTUAL_GENOTYPE_LENGTH,\012					 offspring_genotype);\012\012			//printf(\"AFTER GEN NEW GENOTYPE, %u\\n\",new_pop_cnt);\012\012\012			//printf(\"BEFORE GA CHANNEL, %u\\n\",new_pop_cnt);\012			// --------------------------------------------------------------\012			// Send genotypes to channel\012			// --------------------------------------------------------------\012\012			for (uint pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {\012				write_channel_altera(chan_GA2Conf_genotype, offspring_genotype[pipe_cnt]);\012			}\012\012			active = 1;\012			mode = 2;\012			write_channel_altera(chan_GA2Conf_active, active);\012			write_channel_altera(chan_GA2Conf_mode,   mode);\012			write_channel_altera(chan_GA2Conf_cnt,    new_pop_cnt);\012\012			// --------------------------------------------------------------\012			//printf(\"AFTER GA CHANNEL, %u\\n\",new_pop_cnt);\012\012			//copying offspring to population\012			// **********************************************\012			// ADD VENDOR SPECIFIC PRAGMA\012			// **********************************************\012			\012			//LOOP_GEN_GENERATIONAL_3:\012			//for (uint gene_cnt = 0; gene_cnt < ACTUAL_GENOTYPE_LENGTH; gene_cnt++) {\012			//	GlobPopulationNext[new_pop_cnt*ACTUAL_GENOTYPE_LENGTH + gene_cnt] = offspring_genotype[gene_cnt];\012			//}\012			\012			async_work_group_copy(GlobPopulationNext+new_pop_cnt*ACTUAL_GENOTYPE_LENGTH, offspring_genotype, ACTUAL_GENOTYPE_LENGTH, 0);\012	\012			#if defined (DEBUG_LEO)\012			printf(\"eval_cnt (INC): %u, new_pop_cnt (INC): %u\\n\", eval_cnt, new_pop_cnt);\012			#endif\012			\012\012\012		\012		} // End of LOOP_GEN_GENERATIONAL_2\012		// -----------------------------------------------------------------------\012\012\012\012\012\012		\012\012\012		#if defined (DEBUG_LEO)\012		printf(\"End of loop of new_pop_cnt, new_pop_cnt = %u\\n\", new_pop_cnt);\012		#endif\012\012\012\012\012\012\012\012		// --------------------------------------------------------------\012		// Send DUMMY genotypes to channel to signal GG stop\012		// --------------------------------------------------------------\012		for (uint pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {\012			write_channel_altera(chan_GA2Conf_genotype, 0);\012		}\012		active = 1;\012		mode   = 0;\012		write_channel_altera(chan_GA2Conf_active, active);\012		write_channel_altera(chan_GA2Conf_mode,   mode);\012		write_channel_altera(chan_GA2Conf_cnt,    0);\012\012		ack = read_channel_altera(chan_Store2GA_ack);\012		//printf(\"GG ack: %u\\n\", ack);\012		// --------------------------------------------------------------\012		\012\012\012\012\012		// Updating old population with new one\012		// **********************************************\012		// ADD VENDOR SPECIFIC PRAGMA\012		// **********************************************\012		for (uint i=0;i<DockConst->pop_size*ACTUAL_GENOTYPE_LENGTH; i++)\012		{\012			GlobPopulationCurrent[i] = GlobPopulationNext[i];\012		}\012\012		// Updating old energy with new one\012		// **********************************************\012		// ADD VENDOR SPECIFIC PRAGMA\012		// **********************************************\012		for (uint i=0;i<DockConst->pop_size; i++)\012		{\012			GlobEnergyCurrent[i] = GlobEnergyNext[i];\012		}\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012		evals_for_ls_in_this_cycle = 0;\012\012		#if defined (DEBUG_LEO)\012		printf(\"num_of_entity_for_ls: %u \\n\", DockConst->num_of_lsentities);\012		#endif\012\012\012\012\012\012\012\012\012\012		// -----------------------------------------------------------------------\012		// **********************************************\012		// ADD VENDOR SPECIFIC PRAGMA\012		// **********************************************\012		LOOP_GEN_GENERATIONAL_4:\012		//subjecting num_of_entity_for_ls pieces of offsprings to LS\012		for (uint ls_ent_cnt=0; ls_ent_cnt<DockConst->num_of_lsentities; ls_ent_cnt++)	\012		{\012			//choosing an entity randomly,\012			//and without checking if it has already been subjected to LS in this cycle\012			entity_for_ls = myrand_uint(GlobPRNG, DockConst->pop_size);\012\012			#if defined (DEBUG_LEO)\012			printf(\"entity_for_ls: %u\\n\", entity_for_ls);\012			#endif\012\012\012			#if defined (DEBUG_KERNEL1)\012			printf(\"Entity %u before local search: \", entity_for_ls);\012			for (j=0; j<DockConst->rotbondlist_length+6; j++) {\012				printf(\"%f \", GlobPopulationCurrent [entity_for_ls*ACTUAL_GENOTYPE_LENGTH + j]);\012			}\012			printf(\"   energies: %f \\n\", GlobEnergyCurrent [entity_for_ls]);\012			#endif\012\012			//printf(\"BEFORE LS, %u\\n\",ls_ent_cnt);\012			//performing local search\012			//async_work_group_copy(local_entity_ls, GlobPopulationCurrent+entity_for_ls*ACTUAL_GENOTYPE_LENGTH, ACTUAL_GENOTYPE_LENGTH, 0);\012			//local_entity_energy = GlobEnergyCurrent[entity_for_ls];\012\012			perform_LS(GlobPopulationCurrent,\012				   GlobEnergyCurrent,\012				   GlobPRNG,\012				   KerConst,\012				   DockConst,\012				   entity_for_ls,\012				   local_entity_ls,\012				   entity_possible_new_genotype,\012				   &LS_eval);\012\012			//async_work_group_copy(GlobPopulationCurrent+entity_for_ls*ACTUAL_GENOTYPE_LENGTH, local_entity_ls, ACTUAL_GENOTYPE_LENGTH, 0);\012\012			//printf(\"AFTER LS, %u\\n\",ls_ent_cnt);\012\012\012			eval_cnt += LS_eval;\012			evals_for_ls_in_this_cycle += LS_eval;\012\012\012			#if defined (DEBUG_KERNEL1)\012			printf(\"Entity %u after local search (%u evaluations): \", entity_for_ls, LS_eval);\012			for (j=0; j<myligand_num_of_rotbonds+6; j++) {printf(\"%f \", GlobPopulation [entity_for_ls*40 + j]);}\012			printf(\"   energies: %f %f\\n\",\012				   GlobPopulation [entity_for_ls*40 + 38],\012				   GlobPopulation [entity_for_ls*40 + 39]);\012			#endif\012\012			num_of_evals_for_ls += LS_eval;\012\012			#if defined (DEBUG_LEO)\012			printf(\"eval_cnt (INC): %u, evals_for_ls_in_this_cycle(INC): % u\\n\", eval_cnt, evals_for_ls_in_this_cycle);\012			#endif\012\012\012		} // End of LOOP_GEN_GENERATIONAL_4\012\012		// -----------------------------------------------------------------------\012\012		generation_cnt++;\012\012		//#if defined (DEBUG_LEO)\012		printf(\"eval_cnt: %u, generation_cnt: %u\\n\", eval_cnt, generation_cnt);\012		//#endif\012\012\012\012\012	} // End of while ((eval_cnt < mypars->num_of_energy_evals) && (generation_cnt < mypars->num_of_generations))\012\012\012	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\012	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\012*/\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012\012	printf(\"	%-20s: %s\\n\", \"Krnl_GA\", \"has finished execution!\");\012\012	\012	active = 0;\012	mode = 4;\012\012	// --------------------------------------------------------------\012	// Send DUMMY genotypes to channel\012	// --------------------------------------------------------------\012	for (uint pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {\012		write_channel_altera(chan_GA2Conf_genotype, 0);\012	}\012	write_channel_altera(chan_GA2Conf_active, active);\012	write_channel_altera(chan_GA2Conf_mode,   mode);\012	write_channel_altera(chan_GA2Conf_cnt,    0);\012	// --------------------------------------------------------------\012\012\012	GlobEvals_performed[0]       =  eval_cnt;\012	GlobGenerations_performed[0] =  generation_cnt;\012\012	#if defined (DEBUG_KERNEL1)\012	printf(\"Energy evaluations for LS: %u out of %u\\n\", num_of_evals_for_ls, eval_cnt);\012	printf(\"Number of generations: %u\\n\", generation_cnt);\012	#endif\012}\012\012// --------------------------------------------------------------------------\012// --------------------------------------------------------------------------\012\012\012#include \"Krnl_Conform.cl\"\012#include \"Krnl_InterE.cl\"\012#include \"Krnl_IntraE.cl\"\012#include \"Krnl_Store.cl\"\012\012"}, {"index":1, "path":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Conform.cl", "name":"Krnl_Conform.cl", "content":"// --------------------------------------------------------------------------\012// The function changes the conformation of myligand according to \012// the genotype given by the second parameter.\012// Originally from: processligand.c\012// --------------------------------------------------------------------------\012__kernel\012void Krnl_Conform(\012             //__global const float*           restrict GlobFgrids,\012	     //__global       float*           restrict GlobPopulationCurrent,\012	     //__global       float*           restrict GlobEnergyCurrent,\012	     //__global       float*           restrict GlobPopulationNext,\012	     //__global       float*           restrict GlobEnergyNext,\012             //__global       unsigned int*    restrict GlobPRNG,\012	     __global const kernelconstant*  restrict KerConst,\012	     __global const Dockparameters*  restrict DockConst)\012{\012\012	__local float loc_coords_x[MAX_NUM_OF_ATOMS];\012	__local float loc_coords_y[MAX_NUM_OF_ATOMS];\012	__local float loc_coords_z[MAX_NUM_OF_ATOMS];\012	__local float genotype[ACTUAL_GENOTYPE_LENGTH];\012\012	char active = 1;\012	char mode   = 0;\012	uint cnt    = 0;    \012\012	float phi, theta, genrotangle;\012	float genrot_unitvec [3];\012\012	int rotation_list_element;\012	uint atom_id, rotbond_id;\012	float atom_to_rotate[3];\012	float rotation_unitvec[3];\012	float rotation_movingvec[3];\012	float rotation_angle;\012	float sin_angle;\012	float quatrot_left_x, quatrot_left_y, quatrot_left_z, quatrot_left_q;\012	float quatrot_temp_x, quatrot_temp_y, quatrot_temp_z, quatrot_temp_q;\012\012while(active) {\012\012	//printf(\"BEFORE In CONFORM CHANNEL\\n\");\012	// --------------------------------------------------------------\012	// Wait for genotypes in channel\012	// --------------------------------------------------------------\012\012	for (uint pipe_cnt=0; pipe_cnt<ACTUAL_GENOTYPE_LENGTH; pipe_cnt++) {\012		genotype[pipe_cnt] = read_channel_altera(chan_GA2Conf_genotype);\012	}\012\012	active = read_channel_altera(chan_GA2Conf_active);\012	if (active == 0) {printf(\"	%-20s: %s\\n\", \"Krnl_Conform\", \"disabled\");}\012	\012	mode   = read_channel_altera(chan_GA2Conf_mode);\012	cnt    = read_channel_altera(chan_GA2Conf_cnt);\012	// --------------------------------------------------------------\012	//printf(\"AFTER In CONFORM CHANNEL\\n\");\012\012	phi         = genotype [3]*DEG_TO_RAD;\012	theta       = genotype [4]*DEG_TO_RAD;\012	genrotangle = genotype [5]*DEG_TO_RAD;\012\012	#if defined (NATIVE_PRECISION)\012	genrot_unitvec [0] = native_sin(theta)*native_cos(phi);\012	genrot_unitvec [1] = native_sin(theta)*native_sin(phi);\012	genrot_unitvec [2] = native_cos(theta);\012	#else\012	genrot_unitvec [0] = sin(theta)*cos(phi);\012	genrot_unitvec [1] = sin(theta)*sin(phi);\012	genrot_unitvec [2] = cos(theta);\012	#endif\012	\012	\012\012	// **********************************************\012	// ADD VENDOR SPECIFIC PRAGMA\012	// **********************************************\012	LOOP_CHANGE_CONFORM_1:\012	for (uint rotation_counter = 0; rotation_counter < DockConst->rotbondlist_length; rotation_counter++)\012	{\012		rotation_list_element = KerConst->rotlist_const[rotation_counter];\012\012		if ((rotation_list_element & RLIST_DUMMY_MASK) == 0)	//if not dummy rotation\012		{\012			atom_id = rotation_list_element & RLIST_ATOMID_MASK;\012\012			//capturing atom coordinates\012			if ((rotation_list_element & RLIST_FIRSTROT_MASK) != 0)	//if first rotation of this atom\012			{\012				atom_to_rotate[0] = KerConst->ref_coords_x_const[atom_id];\012				atom_to_rotate[1] = KerConst->ref_coords_y_const[atom_id];\012				atom_to_rotate[2] = KerConst->ref_coords_z_const[atom_id];\012			}\012			else\012			{\012				atom_to_rotate[0] = loc_coords_x[atom_id];\012				atom_to_rotate[1] = loc_coords_y[atom_id];\012				atom_to_rotate[2] = loc_coords_z[atom_id];\012			}\012\012			//capturing rotation vectors and angle\012			if ((rotation_list_element & RLIST_GENROT_MASK) != 0)	//if general rotation\012			{\012				rotation_unitvec[0] = genrot_unitvec[0];\012				rotation_unitvec[1] = genrot_unitvec[1];\012				rotation_unitvec[2] = genrot_unitvec[2];\012\012				rotation_angle = genrotangle;\012\012				rotation_movingvec[0] = genotype[0];\012				rotation_movingvec[1] = genotype[1];\012				rotation_movingvec[2] = genotype[2];\012			}\012			else	//if rotating around rotatable bond\012			{\012				rotbond_id = (rotation_list_element & RLIST_RBONDID_MASK) >> RLIST_RBONDID_SHIFT;\012	\012				rotation_unitvec[0] = KerConst->rotbonds_unit_vectors_const[3*rotbond_id];\012				rotation_unitvec[1] = KerConst->rotbonds_unit_vectors_const[3*rotbond_id+1];\012				rotation_unitvec[2] = KerConst->rotbonds_unit_vectors_const[3*rotbond_id+2];\012				rotation_angle = genotype[6+rotbond_id]*DEG_TO_RAD;\012\012				rotation_movingvec[0] = KerConst->rotbonds_moving_vectors_const[3*rotbond_id];\012				rotation_movingvec[1] = KerConst->rotbonds_moving_vectors_const[3*rotbond_id+1];\012				rotation_movingvec[2] = KerConst->rotbonds_moving_vectors_const[3*rotbond_id+2];\012\012				//in addition performing the first movement \012				//which is needed only if rotating around rotatable bond\012				atom_to_rotate[0] -= rotation_movingvec[0];\012				atom_to_rotate[1] -= rotation_movingvec[1];\012				atom_to_rotate[2] -= rotation_movingvec[2];\012			}\012\012			//performing rotation\012			rotation_angle = rotation_angle/2;\012			quatrot_left_q = cos(rotation_angle);\012			sin_angle = sin(rotation_angle);\012\012			quatrot_left_x = sin_angle*rotation_unitvec[0];\012			quatrot_left_y = sin_angle*rotation_unitvec[1];\012			quatrot_left_z = sin_angle*rotation_unitvec[2];\012\012			if ((rotation_list_element & RLIST_GENROT_MASK) != 0)	//if general rotation, \012										//two rotations should be performed \012										//(multiplying the quaternions)\012			{\012				//calculating quatrot_left*ref_orientation_quats_const, \012				//which means that reference orientation rotation is the first\012				quatrot_temp_q = quatrot_left_q;\012				quatrot_temp_x = quatrot_left_x;\012				quatrot_temp_y = quatrot_left_y;\012				quatrot_temp_z = quatrot_left_z;\012\012				// L30nardoSV: taking the first element of ref_orientation_quats_const member\012				quatrot_left_q = quatrot_temp_q*KerConst->ref_orientation_quats_const[0]-\012						 quatrot_temp_x*KerConst->ref_orientation_quats_const[1]-\012						 quatrot_temp_y*KerConst->ref_orientation_quats_const[2]-\012						 quatrot_temp_z*KerConst->ref_orientation_quats_const[3];\012				quatrot_left_x = quatrot_temp_q*KerConst->ref_orientation_quats_const[1]+\012						 KerConst->ref_orientation_quats_const[0]*quatrot_temp_x+\012						 quatrot_temp_y*KerConst->ref_orientation_quats_const[3]-\012						 KerConst->ref_orientation_quats_const[2]*quatrot_temp_z;\012				quatrot_left_y = quatrot_temp_q*KerConst->ref_orientation_quats_const[2]+\012						 KerConst->ref_orientation_quats_const[0]*quatrot_temp_y+\012						 KerConst->ref_orientation_quats_const[1]*quatrot_temp_z-\012						 quatrot_temp_x*KerConst->ref_orientation_quats_const[3];\012				quatrot_left_z = quatrot_temp_q*KerConst->ref_orientation_quats_const[3]+\012						 KerConst->ref_orientation_quats_const[0]*quatrot_temp_z+\012						 quatrot_temp_x*KerConst->ref_orientation_quats_const[2]-\012						 KerConst->ref_orientation_quats_const[1]*quatrot_temp_y;\012\012			}\012\012			quatrot_temp_q = 0 -\012					 quatrot_left_x*atom_to_rotate [0] -\012					 quatrot_left_y*atom_to_rotate [1] -\012					 quatrot_left_z*atom_to_rotate [2];\012			quatrot_temp_x = quatrot_left_q*atom_to_rotate [0] +\012					 quatrot_left_y*atom_to_rotate [2] -\012					 quatrot_left_z*atom_to_rotate [1];\012			quatrot_temp_y = quatrot_left_q*atom_to_rotate [1] -\012					 quatrot_left_x*atom_to_rotate [2] +\012					 quatrot_left_z*atom_to_rotate [0];\012			quatrot_temp_z = quatrot_left_q*atom_to_rotate [2] +\012					 quatrot_left_x*atom_to_rotate [1] -\012					 quatrot_left_y*atom_to_rotate [0];\012\012			atom_to_rotate [0] = 0 -\012					     quatrot_temp_q*quatrot_left_x +\012					     quatrot_temp_x*quatrot_left_q -\012					     quatrot_temp_y*quatrot_left_z +\012					     quatrot_temp_z*quatrot_left_y;\012			atom_to_rotate [1] = 0 -\012					     quatrot_temp_q*quatrot_left_y +\012					     quatrot_temp_x*quatrot_left_z +\012					     quatrot_temp_y*quatrot_left_q -\012					     quatrot_temp_z*quatrot_left_x;\012			atom_to_rotate [2] = 0 -\012					     quatrot_temp_q*quatrot_left_z -\012					     quatrot_temp_x*quatrot_left_y +\012					     quatrot_temp_y*quatrot_left_x +\012					     quatrot_temp_z*quatrot_left_q;\012\012			//performing final movement and storing values\012			loc_coords_x[atom_id] = atom_to_rotate [0] + rotation_movingvec[0];\012			loc_coords_y[atom_id] = atom_to_rotate [1] + rotation_movingvec[1];\012			loc_coords_z[atom_id] = atom_to_rotate [2] + rotation_movingvec[2];\012\012		} // End if-statement not dummy rotation\012	} // End rotation_counter for-loop\012\012	//printf(\"BEFORE Out CONFORM CHANNEL\\n\");\012	// --------------------------------------------------------------\012	// Send ligand atomic coordinates to channel \012	// --------------------------------------------------------------\012/*\012	for (uint pipe_cnt=0; pipe_cnt<DockConst->num_of_atoms; pipe_cnt++) {\012		write_channel_altera(chan_Conf2Intere_x, loc_coords_x[pipe_cnt]);\012		mem_fence(CLK_CHANNEL_MEM_FENCE);\012		write_channel_altera(chan_Conf2Intere_y, loc_coords_y[pipe_cnt]);\012		mem_fence(CLK_CHANNEL_MEM_FENCE);\012		write_channel_altera(chan_Conf2Intere_z, loc_coords_z[pipe_cnt]);\012		//mem_fence(CLK_CHANNEL_MEM_FENCE);\012\012		write_channel_altera(chan_Conf2Intrae_x, loc_coords_x[pipe_cnt]);\012		mem_fence(CLK_CHANNEL_MEM_FENCE);\012		write_channel_altera(chan_Conf2Intrae_y, loc_coords_y[pipe_cnt]);\012		mem_fence(CLK_CHANNEL_MEM_FENCE);\012		write_channel_altera(chan_Conf2Intrae_z, loc_coords_z[pipe_cnt]);\012	}\012*/\012\012\012	for (uint pipe_cnt=0; pipe_cnt<DockConst->num_of_atoms; pipe_cnt++) {\012		write_channel_altera(chan_Conf2Intere_x, loc_coords_x[pipe_cnt]);\012		write_channel_altera(chan_Conf2Intrae_x, loc_coords_x[pipe_cnt]);\012		mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);\012		write_channel_altera(chan_Conf2Intere_y, loc_coords_y[pipe_cnt]);\012		write_channel_altera(chan_Conf2Intrae_y, loc_coords_y[pipe_cnt]);\012		mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);\012		write_channel_altera(chan_Conf2Intere_z, loc_coords_z[pipe_cnt]);\012		write_channel_altera(chan_Conf2Intrae_z, loc_coords_z[pipe_cnt]);\012		mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);\012		write_channel_altera(chan_Conf2Intere_active, active);\012		write_channel_altera(chan_Conf2Intrae_active, active);\012		mem_fence(CLK_CHANNEL_MEM_FENCE);\012		write_channel_altera(chan_Conf2Intere_mode,   mode);\012		write_channel_altera(chan_Conf2Intrae_mode,   mode);\012		mem_fence(CLK_CHANNEL_MEM_FENCE);\012		write_channel_altera(chan_Conf2Intere_cnt,    cnt);\012		write_channel_altera(chan_Conf2Intrae_cnt,    cnt);\012	}\012	// --------------------------------------------------------------\012	//printf(\"AFTER Out CONFORM CHANNEL\\n\");\012\012} // End of while(1)\012\012}\012// --------------------------------------------------------------------------\012// --------------------------------------------------------------------------\012"}, {"index":2, "path":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_InterE.cl", "name":"Krnl_InterE.cl", "content":"// --------------------------------------------------------------------------\012// The function calculates the intermolecular energy of a ligand given by \012// myligand parameter, and a receptor represented as a grid. \012// The grid point values must be stored at the location which starts at GlobFgrids, \012// the memory content can be generated with get_gridvalues function.\012// The mygrid parameter must be the corresponding grid informtaion. \012// If an atom is outside the grid, the coordinates will be changed with \012// the value of outofgrid_tolerance, \012// if it remains outside, a very high value will be added to the current energy as a penalty. \012// Originally from: processligand.c\012// --------------------------------------------------------------------------\012__kernel\012void Krnl_InterE(\012             __global const float*           restrict GlobFgrids,\012	     //__global       float*           restrict GlobPopulationCurrent,\012	     //__global       float*           restrict GlobEnergyCurrent,\012	     //__global       float*           restrict GlobPopulationNext,\012	     //__global       float*           restrict GlobEnergyNext,\012             //__global       unsigned int*    restrict GlobPRNG,\012	     __global const kernelconstant*  restrict KerConst,\012	     __global const Dockparameters*  restrict DockConst)\012{\012\012	//__local float loc_coords_x[MAX_NUM_OF_ATOMS];\012	//__local float loc_coords_y[MAX_NUM_OF_ATOMS];\012	//__local float loc_coords_z[MAX_NUM_OF_ATOMS];\012\012\012	float loc_coords_x[MAX_NUM_OF_ATOMS];\012	float loc_coords_y[MAX_NUM_OF_ATOMS];\012	float loc_coords_z[MAX_NUM_OF_ATOMS];\012\012\012	char active = 1;\012	char mode   = 0;\012	uint cnt    = 0;   \012\012	float interE;\012	char atom1_id, atom1_typeid;\012	float x, y, z, dx, dy, dz, q;\012	float cube [2][2][2];\012	float weights [2][2][2];\012	int x_low, x_high, y_low, y_high, z_low, z_high;\012\012	// L30nardoSV	\012	unsigned int  mul_tmp;\012	unsigned char g1 = DockConst->gridsize_x; 	\012	unsigned int  g2 = DockConst->gridsize_x * DockConst->gridsize_y;         \012	unsigned int  g3 = DockConst->gridsize_x * DockConst->gridsize_y * DockConst->gridsize_z;\012        unsigned int  ylow_times_g1, yhigh_times_g1;\012        unsigned int  zlow_times_g2, zhigh_times_g2;\012	unsigned int  cube_000, cube_100, cube_010, cube_110;\012        unsigned int  cube_001, cube_101, cube_011, cube_111;\012\012while(active) {\012	//printf(\"BEFORE In INTER CHANNEL\\n\");\012	// --------------------------------------------------------------\012	// Wait for ligand atomic coordinates in channel\012	// --------------------------------------------------------------\012\012	for (uint pipe_cnt=0; pipe_cnt<DockConst->num_of_atoms; pipe_cnt++) {\012		loc_coords_x[pipe_cnt] = read_channel_altera(chan_Conf2Intere_x);\012		mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);\012		loc_coords_y[pipe_cnt] = read_channel_altera(chan_Conf2Intere_y);\012		mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);\012		loc_coords_z[pipe_cnt] = read_channel_altera(chan_Conf2Intere_z);\012		mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);\012		active = read_channel_altera(chan_Conf2Intere_active);\012		mem_fence(CLK_CHANNEL_MEM_FENCE);\012		mode   = read_channel_altera(chan_Conf2Intere_mode);\012		mem_fence(CLK_CHANNEL_MEM_FENCE);\012		cnt    = read_channel_altera(chan_Conf2Intere_cnt);\012	}\012	// --------------------------------------------------------------\012	//printf(\"AFTER In INTER CHANNEL\\n\");\012\012	if (active == 0) {printf(\"	%-20s: %s\\n\", \"Krnl_InterE\", \"disabled\");}\012\012	interE = 0.0f;\012\012\012	// for each atom\012	// **********************************************\012	// ADD VENDOR SPECIFIC PRAGMA	\012	// **********************************************\012	LOOP_INTERE_1:\012	for (atom1_id=0; atom1_id<DockConst->num_of_atoms; atom1_id++)		\012	{\012		atom1_typeid = KerConst->atom_types_const[atom1_id];\012		x = loc_coords_x[atom1_id];\012		y = loc_coords_y[atom1_id];\012		z = loc_coords_z[atom1_id];\012		q = KerConst->atom_charges_const[atom1_id];\012\012		// if the atom is outside of the grid\012		if ((x < 0.0f) || (x >= DockConst->gridsize_x-1) || \012		    (y < 0.0f) || (y >= DockConst->gridsize_y-1) ||\012		    (z < 0.0f) || (z >= DockConst->gridsize_z-1))	\012		{\012			//penalty is 2^24 for each atom outside the grid\012			interE += 16777216.0f; \012		} \012		else \012		{\012			x_low  = convert_int(floor(x));\012			y_low  = convert_int(floor(y));\012			z_low  = convert_int(floor(z));\012			x_high = convert_int(ceil(x));	 \012			y_high = convert_int(ceil(y));\012			z_high = convert_int(ceil(z));\012			dx = x - x_low; dy = y - y_low; dz = z - z_low;\012\012			// Calculates the weights for trilinear interpolation\012			// based on the location of the point inside\012			weights [0][0][0] = (1-dx)*(1-dy)*(1-dz);\012			weights [1][0][0] = dx*(1-dy)*(1-dz);\012			weights [0][1][0] = (1-dx)*dy*(1-dz);\012			weights [1][1][0] = dx*dy*(1-dz);\012			weights [0][0][1] = (1-dx)*(1-dy)*dz;\012			weights [1][0][1] = dx*(1-dy)*dz;\012			weights [0][1][1] = (1-dx)*dy*dz;\012			weights [1][1][1] = dx*dy*dz;\012\012			#if defined (DEBUG_KERNEL_INTER_E)\012			printf(\"\\n\\nPartial results for atom with id %i:\\n\", atom1_id);\012			printf(\"x_low = %d, x_high = %d, x_frac = %f\\n\", x_low, x_high, dx);\012			printf(\"y_low = %d, y_high = %d, y_frac = %f\\n\", y_low, y_high, dy);\012			printf(\"z_low = %d, z_high = %d, z_frac = %f\\n\\n\", z_low, z_high, dz);\012			printf(\"coeff(0,0,0) = %f\\n\", weights [0][0][0]);\012			printf(\"coeff(1,0,0) = %f\\n\", weights [1][0][0]);\012			printf(\"coeff(0,1,0) = %f\\n\", weights [0][1][0]);\012			printf(\"coeff(1,1,0) = %f\\n\", weights [1][1][0]);\012			printf(\"coeff(0,0,1) = %f\\n\", weights [0][0][1]);\012			printf(\"coeff(1,0,1) = %f\\n\", weights [1][0][1]);\012			printf(\"coeff(0,1,1) = %f\\n\", weights [0][1][1]);\012			printf(\"coeff(1,1,1) = %f\\n\", weights [1][1][1]);\012			#endif\012\012			// L30nardoSV\012			ylow_times_g1  = y_low*g1;	yhigh_times_g1 = y_high*g1;\012        	        zlow_times_g2  = z_low*g2;	zhigh_times_g2 = z_high*g2;\012        	        cube_000 = x_low  + ylow_times_g1  + zlow_times_g2;\012        	        cube_100 = x_high + ylow_times_g1  + zlow_times_g2;\012        	        cube_010 = x_low  + yhigh_times_g1 + zlow_times_g2;\012        	        cube_110 = x_high + yhigh_times_g1 + zlow_times_g2;\012        	        cube_001 = x_low  + ylow_times_g1  + zhigh_times_g2;\012        	        cube_101 = x_high + ylow_times_g1  + zhigh_times_g2;\012        	        cube_011 = x_low  + yhigh_times_g1 + zhigh_times_g2;\012        	        cube_111 = x_high + yhigh_times_g1 + zhigh_times_g2;\012        	        mul_tmp = atom1_typeid*g3;\012\012			//energy contribution of the current grid type\012	                cube [0][0][0] = *(GlobFgrids + cube_000 + mul_tmp);\012        	        cube [1][0][0] = *(GlobFgrids + cube_100 + mul_tmp);\012        	        cube [0][1][0] = *(GlobFgrids + cube_010 + mul_tmp);\012        	        cube [1][1][0] = *(GlobFgrids + cube_110 + mul_tmp);\012        	        cube [0][0][1] = *(GlobFgrids + cube_001 + mul_tmp);\012        	        cube [1][0][1] = *(GlobFgrids + cube_101 + mul_tmp);\012        	        cube [0][1][1] = *(GlobFgrids + cube_011 + mul_tmp);\012        	        cube [1][1][1] = *(GlobFgrids + cube_111 + mul_tmp);\012		\012			#if defined (DEBUG_KERNEL_INTER_E)\012			printf(\"Interpolation of van der Waals map:\\n\");\012			printf(\"cube(0,0,0) = %f\\n\", cube [0][0][0]);\012			printf(\"cube(1,0,0) = %f\\n\", cube [1][0][0]);\012			printf(\"cube(0,1,0) = %f\\n\", cube [0][1][0]);\012			printf(\"cube(1,1,0) = %f\\n\", cube [1][1][0]);\012			printf(\"cube(0,0,1) = %f\\n\", cube [0][0][1]);\012			printf(\"cube(1,0,1) = %f\\n\", cube [1][0][1]);\012			printf(\"cube(0,1,1) = %f\\n\", cube [0][1][1]);\012			printf(\"cube(1,1,1) = %f\\n\", cube [1][1][1]);\012			#endif\012\012			interE += TRILININTERPOL(cube, weights);\012\012			#if defined (DEBUG_KERNEL_INTER_E)\012			printf(\"interpolated value = %f\\n\\n\", TRILININTERPOL(cube, weights));\012			#endif\012\012			//energy contribution of the electrostatic grid\012			atom1_typeid = DockConst->num_of_atypes;\012			mul_tmp = atom1_typeid*g3;\012        	        cube [0][0][0] = *(GlobFgrids + cube_000 + mul_tmp);\012        	        cube [1][0][0] = *(GlobFgrids + cube_100 + mul_tmp);\012        	        cube [0][1][0] = *(GlobFgrids + cube_010 + mul_tmp);\012        	        cube [1][1][0] = *(GlobFgrids + cube_110 + mul_tmp);\012        	        cube [0][0][1] = *(GlobFgrids + cube_001 + mul_tmp);\012        	        cube [1][0][1] = *(GlobFgrids + cube_101 + mul_tmp);\012        	        cube [0][1][1] = *(GlobFgrids + cube_011 + mul_tmp);\012        	        cube [1][1][1] = *(GlobFgrids + cube_111 + mul_tmp);\012\012			#if defined (DEBUG_KERNEL_INTER_E)\012			printf(\"Interpolation of electrostatic map:\\n\");\012			printf(\"cube(0,0,0) = %f\\n\", cube [0][0][0]);\012			printf(\"cube(1,0,0) = %f\\n\", cube [1][0][0]);\012			printf(\"cube(0,1,0) = %f\\n\", cube [0][1][0]);\012			printf(\"cube(1,1,0) = %f\\n\", cube [1][1][0]);\012			printf(\"cube(0,0,1) = %f\\n\", cube [0][0][1]);\012			printf(\"cube(1,0,1) = %f\\n\", cube [1][0][1]);\012			printf(\"cube(0,1,1) = %f\\n\", cube [0][1][1]);\012			printf(\"cube(1,1,1) = %f\\n\", cube [1][1][1]);\012			#endif\012\012			interE += q * TRILININTERPOL(cube, weights);\012\012			#if defined (DEBUG_KERNEL_INTER_E)\012			printf(\"interpoated value = %f, multiplied by q = %f\\n\\n\", TRILININTERPOL(cube, weights), q*TRILININTERPOL(cube, weights));\012			#endif\012\012			//energy contribution of the desolvation grid\012			atom1_typeid = DockConst->num_of_atypes+1;\012			mul_tmp = atom1_typeid*g3;\012        	        cube [0][0][0] = *(GlobFgrids + cube_000 + mul_tmp);\012        	        cube [1][0][0] = *(GlobFgrids + cube_100 + mul_tmp);\012        	        cube [0][1][0] = *(GlobFgrids + cube_010 + mul_tmp);\012        	        cube [1][1][0] = *(GlobFgrids + cube_110 + mul_tmp);\012        	        cube [0][0][1] = *(GlobFgrids + cube_001 + mul_tmp);\012        	        cube [1][0][1] = *(GlobFgrids + cube_101 + mul_tmp);\012        	        cube [0][1][1] = *(GlobFgrids + cube_011 + mul_tmp);\012        	        cube [1][1][1] = *(GlobFgrids + cube_111 + mul_tmp);\012\012			#if defined (DEBUG_KERNEL_INTER_E)\012			printf(\"Interpolation of desolvation map:\\n\");\012			printf(\"cube(0,0,0) = %f\\n\", cube [0][0][0]);\012			printf(\"cube(1,0,0) = %f\\n\", cube [1][0][0]);\012			printf(\"cube(0,1,0) = %f\\n\", cube [0][1][0]);\012			printf(\"cube(1,1,0) = %f\\n\", cube [1][1][0]);\012			printf(\"cube(0,0,1) = %f\\n\", cube [0][0][1]);\012			printf(\"cube(1,0,1) = %f\\n\", cube [1][0][1]);\012			printf(\"cube(0,1,1) = %f\\n\", cube [0][1][1]);\012			printf(\"cube(1,1,1) = %f\\n\", cube [1][1][1]);\012			#endif\012\012			interE += fabs(q) * TRILININTERPOL(cube, weights);\012\012			#if defined (DEBUG_KERNEL_KERNEL_INTER_E)\012			printf(\"interploated value = %f, multiplied by abs(q) = %f\\n\\n\", TRILININTERPOL(cube, weights), fabs(q) * trilin_interpol(cube, weights));\012			printf(\"Current value of intermolecular energy = %f\\n\\n\\n\", interE);\012			#endif\012		}\012	} // End of LOOP_INTERE_1:	\012\012	// --------------------------------------------------------------\012	// Send intermolecular energy to chanel\012	// --------------------------------------------------------------\012	write_channel_altera(chan_Intere2Store_intere, interE);\012	mem_fence(CLK_CHANNEL_MEM_FENCE);\012	write_channel_altera(chan_Intere2Store_active, active);\012	mem_fence(CLK_CHANNEL_MEM_FENCE);\012	write_channel_altera(chan_Intere2Store_mode,   mode);\012	mem_fence(CLK_CHANNEL_MEM_FENCE);\012	write_channel_altera(chan_Intere2Store_cnt,    cnt);\012	// --------------------------------------------------------------\012 	\012	} // End of while(1)\012}\012// --------------------------------------------------------------------------\012// --------------------------------------------------------------------------\012"}, {"index":3, "path":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_IntraE.cl", "name":"Krnl_IntraE.cl", "content":"// --------------------------------------------------------------------------\012// Originally from: processligand.c\012// --------------------------------------------------------------------------\012__kernel\012void Krnl_IntraE(\012             //__global const float*           restrict GlobFgrids,\012	     //__global       float*           restrict GlobPopulationCurrent,\012	     //__global       float*           restrict GlobEnergyCurrent,\012	     //__global       float*           restrict GlobPopulationNext,\012	     //__global       float*           restrict GlobEnergyNext,\012             //__global       unsigned int*    restrict GlobPRNG,\012	     __global const kernelconstant*  restrict KerConst,\012	     __global const Dockparameters*  restrict DockConst)\012{\012\012	__local float loc_coords_x[MAX_NUM_OF_ATOMS];\012	__local float loc_coords_y[MAX_NUM_OF_ATOMS];\012	__local float loc_coords_z[MAX_NUM_OF_ATOMS];\012\012	char active = 1;\012	char mode   = 0;\012	uint cnt    = 0;   \012\012	int contributor_counter;\012	char atom1_id, atom2_id, atom1_typeid, atom2_typeid;\012	float subx, suby, subz, distance_leo;\012\012 	// Altera doesn't support power function 	\012	// so this is implemented with multiplications 	\012	// Full precision is used 	\012	float distance_pow_2, distance_pow_4, distance_pow_6, distance_pow_10, distance_pow_12;\012	float intraE;\012\012while(active) {\012	//printf(\"BEFORE In INTRA CHANNEL\\n\");\012	// --------------------------------------------------------------\012	// Wait for ligand atomic coordinates in channel\012	// --------------------------------------------------------------\012\012	for (uint pipe_cnt=0; pipe_cnt<DockConst->num_of_atoms; pipe_cnt++) {\012		loc_coords_x[pipe_cnt] = read_channel_altera(chan_Conf2Intrae_x);\012		mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);\012		loc_coords_y[pipe_cnt] = read_channel_altera(chan_Conf2Intrae_y);\012		mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);\012		loc_coords_z[pipe_cnt] = read_channel_altera(chan_Conf2Intrae_z);\012		mem_fence(CLK_CHANNEL_MEM_FENCE | CLK_LOCAL_MEM_FENCE);\012		active = read_channel_altera(chan_Conf2Intrae_active);\012		mem_fence(CLK_CHANNEL_MEM_FENCE);\012		mode   = read_channel_altera(chan_Conf2Intrae_mode);\012		mem_fence(CLK_CHANNEL_MEM_FENCE);\012		cnt    = read_channel_altera(chan_Conf2Intrae_cnt);\012	}\012	// --------------------------------------------------------------\012	//printf(\"AFTER In INTRA CHANNEL\\n\");\012\012	if (active == 0) {printf(\"	%-20s: %s\\n\", \"Krnl_IntraE\", \"disabled\");}\012\012	intraE = 0.0f;\012\012	//for each intramolecular atom contributor pair\012	// **********************************************\012	// ADD VENDOR SPECIFIC PRAGMA\012	// **********************************************\012	LOOP_INTRAE_1:\012	for (uint contributor_counter=0; contributor_counter<DockConst->num_of_intraE_contributors; contributor_counter++)\012	{	\012		atom1_id = KerConst->intraE_contributors_const[3*contributor_counter]; \012		atom2_id = KerConst->intraE_contributors_const[3*contributor_counter+1];\012\012		subx = loc_coords_x[atom1_id] - loc_coords_x[atom2_id];\012		suby = loc_coords_y[atom1_id] - loc_coords_y[atom2_id];\012		subz = loc_coords_z[atom1_id] - loc_coords_z[atom2_id];\012		distance_leo = sqrt(subx*subx + suby*suby + subz*subz)*DockConst->grid_spacing;\012\012		if (distance_leo < 1.0f) {\012			#if defined (DEBUG_KERNEL_INTRA_E)\012			printf(\"\\n\\nToo low distance (%f) between atoms %u and %u\\n\", distance_leo, atom1_id, atom2_id);\012			#endif\012			//return HIGHEST_ENERGY;	//returning maximal value\012			distance_leo = 1.0f;\012		}\012\012		#if defined (DEBUG_KERNEL_INTRA_E)\012		printf(\"\\n\\nCalculating energy contribution of atoms %u and %u\\n\", atom1_id+1, atom2_id+1);\012		printf(\"Distance: %f\\n\", distance_leo);\012		#endif\012\012		distance_pow_2  = distance_leo*distance_leo; 		\012		distance_pow_4  = distance_pow_2*distance_pow_2; 		\012		distance_pow_6  = distance_pow_2*distance_pow_4; 		\012		distance_pow_10 = distance_pow_4*distance_pow_6; 		\012		distance_pow_12 = distance_pow_6*distance_pow_6;\012		\012		//but only if the distance is less than distance cutoff value and 20.48A (because of the tables)\012		if ((distance_leo < 8.0f) && (distance_leo < 20.48f)) \012		{\012			atom1_typeid = KerConst->atom_types_const [atom1_id];\012			atom2_typeid = KerConst->atom_types_const [atom2_id];\012\012			//calculating van der Waals / hydrogen bond term\012			intraE += KerConst->VWpars_AC_const[atom1_typeid * DockConst->num_of_atypes+atom2_typeid]/distance_pow_12;\012\012			if (KerConst->intraE_contributors_const[3*contributor_counter+2] == 1)	//H-bond\012				intraE-= KerConst->VWpars_BD_const[atom1_typeid*DockConst->num_of_atypes+atom2_typeid]/distance_pow_10;	\012			else	//van der Waals\012				intraE-= KerConst->VWpars_BD_const[atom1_typeid*DockConst->num_of_atypes+atom2_typeid]/distance_pow_6;\012\012			//calculating electrostatic term\012			intraE+= DockConst->coeff_elec*KerConst->atom_charges_const[atom1_id]*KerConst->atom_charges_const[atom2_id]/(distance_leo*(-8.5525f + 86.9525f/(1.0f + 7.7839f*exp(-0.3154f*distance_leo))));\012\012			//calculating desolvation term\012			intraE+= (\012				  ( KerConst->dspars_S_const[atom1_typeid] + DockConst->qasp*fabs(KerConst->atom_charges_const[atom1_id]) ) * KerConst->dspars_V_const[atom2_typeid] + \012				  ( KerConst->dspars_S_const[atom2_typeid] + DockConst->qasp*fabs(KerConst->atom_charges_const[atom2_id]) ) * KerConst->dspars_V_const[atom1_typeid]) * \012				 DockConst->coeff_desolv*exp(-distance_leo*distance_leo/25.92f);\012	\012		} // End of if: if ((dist < dcutoff) && (dist < 20.48))	\012\012	} // End of LOOP_INTRAE_1\012\012	// --------------------------------------------------------------\012	// Send intramolecular energy to channel\012	// --------------------------------------------------------------\012	write_channel_altera(chan_Intrae2Store_intrae, intraE);\012	mem_fence(CLK_CHANNEL_MEM_FENCE);\012	write_channel_altera(chan_Intrae2Store_active, active);\012	mem_fence(CLK_CHANNEL_MEM_FENCE);\012	write_channel_altera(chan_Intrae2Store_mode,   mode);\012	mem_fence(CLK_CHANNEL_MEM_FENCE);\012	write_channel_altera(chan_Intrae2Store_cnt,    cnt);\012	// --------------------------------------------------------------\012\012	} // End of while(1)\012}\012// --------------------------------------------------------------------------\012// --------------------------------------------------------------------------\012"}, {"index":4, "path":"/home/wimi/lvs/ofdock_altera/ofdock_taskpar_alt/device/Krnl_Store.cl", "name":"Krnl_Store.cl", "content":"__kernel\012void Krnl_Store(\012             //__global const float*           restrict GlobFgrids,\012	     //__global       float*           restrict GlobPopulationCurrent,\012	     __global       float*           restrict GlobEnergyCurrent,\012	     //__global       float*           restrict GlobPopulationNext,\012	     __global       float*           restrict GlobEnergyNext\012		//,\012             //__global       unsigned int*    restrict GlobPRNG,\012	     //__global const kernelconstant*  restrict KerConst,\012	     //__global const Dockparameters*  restrict DockConst\012	     )\012{\012	// --------------------------------------------------------------\012	// Wait for enegies\012	// --------------------------------------------------------------\012	float InterE;\012	float IntraE;\012\012	char active = 1;\012	char mode   = 0;\012	uint cnt    = 0;  \012\012 	char active1, active2;\012	char mode1, mode2;\012	uint cnt1, cnt2;\012\012	float LSenergy;\012\012while(active) {\012\012	InterE = read_channel_altera(chan_Intere2Store_intere);\012	IntraE = read_channel_altera(chan_Intrae2Store_intrae);\012	mem_fence(CLK_CHANNEL_MEM_FENCE);\012	active1 = read_channel_altera(chan_Intere2Store_active);\012	active2 = read_channel_altera(chan_Intrae2Store_active);\012	mem_fence(CLK_CHANNEL_MEM_FENCE);\012	mode1 = read_channel_altera(chan_Intere2Store_mode);\012	mode2 = read_channel_altera(chan_Intrae2Store_mode);\012	mem_fence(CLK_CHANNEL_MEM_FENCE);\012	cnt1  = read_channel_altera(chan_Intere2Store_cnt);\012	cnt2  = read_channel_altera(chan_Intrae2Store_cnt);\012\012	// --------------------------------------------------------------\012	\012	if (active1 != active2) {printf(\"Store error: active are not equal!\\n\");}\012	else 			{active = active1;}\012\012	if (mode1 != mode2)     {printf(\"Store error: mode are not equal!\\n\");}\012	else 			{mode = mode1;}\012\012	if (cnt1  != cnt2)      {printf(\"Store error: mode are not equal!\\n\");}\012	else 			{cnt = cnt1;}\012\012	if (active == 0) {printf(\"	%-20s: %s\\n\", \"Krnl_Store\", \"disabled\");}\012\012	switch (mode) {\012/*\012		case 0:	write_channel_altera(chan_Store2GA_ack, 1);	// Signal INI, GG or LS finished \012		break;\012		case 1:	GlobEnergyCurrent[cnt] = InterE + IntraE;	// INI: Init energy calculation of pop\012		break;\012		case 2:	GlobEnergyNext[cnt] = InterE + IntraE;		// GG: Genetic Generation\012		break;\012		case 3:	LSenergy = InterE + IntraE;		// LS: Local Search\012			write_channel_altera(chan_Store2GA_ack, 1);\012			mem_fence(CLK_CHANNEL_MEM_FENCE);\012			write_channel_altera(chan_Store2GA_LSenergy, LSenergy);\012		break;\012*/\012\012\012		case 4:							// Krnl_GA has finished execution!\012		break;\012	}\012\012} // End of while(1)\012\012}\012// --------------------------------------------------------------------------\012// --------------------------------------------------------------------------\012"}];