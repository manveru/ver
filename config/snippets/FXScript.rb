# Encoding: UTF-8

{"dimsof" => 
  {scope: "source.fxscript",
   name: "DimensionsOf",
   content: "DimensionsOf(${1:Dest}, ${2:Width}, ${3:Height});"},
 "generator" => 
  {scope: "source.fxscript",
   name: "Generator",
   content: "Generator \"${1:Name}\";\nGroup \"${2:Name}\";\n"},
 "input" => 
  {scope: "source.fxscript",
   name: "Angle",
   content: 
    "input ${1:varname}, \"${2:${1/varname/text label/}}\", Angle, ${3:default value}, ${4:min value}, ${5:max value};\n"},
 "for" => 
  {scope: "source.fxscript",
   name: "for ... next",
   content: 
    "for ${1:var} = ${2:min} to ${3:max}\n\t${0:${TM_SELECTED_TEXT/(.*)$/$1/: // insert code here}}\nnext;"},
 "setpixelformat" => 
  {scope: "source.fxscript",
   name: "SetPixelFormat",
   content: "SetPixelFormat(${1:dest}, ${2:colorspace});"},
 "displace" => 
  {scope: "source.fxscript",
   name: "Displace",
   content: 
    "Displace(${1:srcImage}, ${2:destImage}, ${3:mapImage}, ${4:repeatEdges}, ${5:xScale}, ${6:yScale}, ${7:lumaScale}, ${8:AspectOf($2)});\n"},
 "channelfill" => 
  {scope: "source.fxscript",
   name: "ChannelFill",
   content: 
    "ChannelFill(${1:destImage}, ${2:a0-255}, ${3:r0-255}, ${4:g0-255}, ${5:b0-255});\n"},
 "bumpmap" => 
  {scope: "source.fxscript",
   name: "BumpMap",
   content: 
    "BumpMap(${1:srcImage}, ${2:destImage}, ${3:mapImage}, ${4:repeatEdges}, ${5:angle}, ${6:scale}, ${7:lumaScale}, ${8:AspectOf($2)});\n"},
 "interpolate" => 
  {scope: "source.fxscript",
   name: "Interpolate",
   content: "Interpolate(${1:p1}, ${2:p2}, ${3:percent}, ${4:result});"},
 "repeat" => 
  {scope: "source.fxscript",
   name: "Repeat While",
   content: 
    "Repeat While (${1:Condition})\n\t${0:${TM_SELECTED_TEXT/(.*)$/$1/: // insert code here}}\nEnd Repeat;"},
 "makerect" => 
  {scope: "source.fxscript",
   name: "MakeRect",
   content: 
    "MakeRect(${1:result}, ${2:left}, ${3:top}, ${4:width}, ${5:height});"},
 "transition" => 
  {scope: "source.fxscript",
   name: "Transition",
   content: "Transition \"${1:Name}\";\nGroup \"${2:Name}\";\n"},
 "channelmultiply" => 
  {scope: "source.fxscript",
   name: "ChannelMultiply",
   content: 
    "ChannelMultiply(${1:srcImage}, ${2:destImage}, ${3:alphaValue}, ${4:redValue}, ${5:greenValue}, ${6:blueValue});"},
 "info" => 
  {scope: "source.fxscript",
   name: "InformationFlag(\"hasfields\")",
   content: "InformationFlag(\"hasfields\");\n"},
 "add" => 
  {scope: "source.fxscript",
   name: "Add",
   content: 
    "Add(${1:srcImage1}, ${2:srcImage2}, ${3:destImage}, ${4:amount}, ${5:kAlpha});"},
 "getvideo" => 
  {scope: "source.fxscript",
   name: "GetVideo",
   content: "GetVideo(${1:srcClip}, ${2:timeOffset}, ${3:destImage});"},
 "invertchannel" => 
  {scope: "source.fxscript",
   name: "InvertChannel",
   content: 
    "InvertChannel(${1:srcImage}, ${2:destImage}, ${3:doAlpha}, ${4:doRed}, ${5:doGreen}, ${6:doBlue});\n"},
 "kformat" => 
  {scope: "source.fxscript", name: "kFormatRGB255", content: "kFormatRGB255"},
 "drawsoftdot" => 
  {scope: "source.fxscript",
   name: "DrawSoftSpot",
   content: 
    "DrawSoftDot(${1:dest}, ${2:point/poly}, ${3:shape}, ${4:size}, ${5:softness}, ${6:subSteps}, ${7:color(s)}, ${8:opacity(s)}, ${9:aspectOf(${10:$1})});"},
 "code" => {scope: "source.fxscript", name: "code", content: "\ncode\n\n"},
 "kfloat" => {scope: "source.fxscript", name: "kFloat2", content: "kFloat2"},
 "fillpoly" => 
  {scope: "source.fxscript",
   name: "FillPoly",
   content: "FillPoly(${1:poly}, ${2:image}, ${3:color});\n"},
 "blur" => 
  {scope: "source.fxscript",
   name: "BlurChannel",
   content: 
    "BlurChannel(${1:srcImage}, ${2:destImage}, ${3:radius}, ${4:doAlpha}, ${5:doRed}, ${6:doGreen}, ${7:doBlue}, ${8:AspectOf(${9:dest})});\n"},
 "multiply" => 
  {scope: "source.fxscript",
   name: "Multiply",
   content: 
    "Multiply(${1:srcImage1}, ${2:srcImage2}, ${3:destImage}, ${4:amount}, ${5:kAlpha});"},
 "colortransform" => 
  {scope: "source.fxscript",
   name: "ColorTransform",
   content: 
    "ColorTransform(${1:srcImage}, ${2:destImage}, ${3:matrix}, ${4:float[3]}, ${5:$4});"},
 "filter" => 
  {scope: "source.fxscript",
   name: "Filter",
   content: "Filter \"${1:Name}\";\nGroup \"${2:Name}\";\n"},
 "screen" => 
  {scope: "source.fxscript",
   name: "Screen",
   content: 
    "Screen(${1:srcImage1}, ${2:srcImage2}, ${3:destImage}, ${4:amount}, ${5:kAlpha});"},
 "overlay" => 
  {scope: "source.fxscript",
   name: "Overlay",
   content: 
    "Overlay(${1:srcImage1}, ${2:srcImage2}, ${3:destImage}, ${4:amount}, ${5:kAlpha});"},
 "if" => 
  {scope: "source.fxscript",
   name: "if ... end",
   content: 
    "if (${1:Condition})\n\t${0:${TM_SELECTED_TEXT/(.*)$/$1/: // insert code here}}\nend if\n"},
 "aspectof" => 
  {scope: "source.fxscript",
   name: "AspectOf(dest)",
   content: "AspectOf(${1:dest});"},
 "boundsof" => 
  {scope: "source.fxscript",
   name: "BoundsOf",
   content: "BoundsOf(${1:image}, ${2:result});"},
 "difference" => 
  {scope: "source.fxscript",
   name: "Difference",
   content: 
    "Difference(${1:srcImage1}, ${2:srcImage2}, ${3:destImage}, ${4:kAlpha});"},
 "getpixelformat" => 
  {scope: "source.fxscript",
   name: "GetPixelFormat",
   content: "GetPixelFormat(${1:src1});"},
 "convertimage" => 
  {scope: "source.fxscript",
   name: "ConvertImage",
   content: "ConvertImage(${1:src1}, ${2:dest}, ${3:colorspace});"},
 "debug" => 
  {scope: "source.fxscript",
   name: "DebugText",
   content: "DebugText(\"${1:label}\", ${2:float value});"},
 "matte" => 
  {scope: "source.fxscript",
   name: "Matte",
   content: 
    "Matte(${1:TopImage}, ${2:BottomImage}, ${3:destImage}, ${4:amount}, ${5:kAlpha});"},
 "channelcopy" => 
  {scope: "source.fxscript",
   name: "ChannelCopy",
   content: 
    "ChannelCopy(${1:srcIMG}, ${2:destIMG}, ${3:channel2Alpha}, ${4:channel2Red}, ${5:channel2Green}, ${6:channel2Blue});\n"},
 "imageand" => 
  {scope: "source.fxscript",
   name: "ImageAnd",
   content: "ImageAnd(${1:srcImage1}, ${2:srcImage2}, ${3:destImage});"},
 "blitrect" => 
  {scope: "source.fxscript",
   name: "BlitRect",
   content: 
    "BlitRect(${1:sourceImage}, ${2:sourcePoly}, ${3:destImage}, ${4:destPoly});\n"},
 "ife" => 
  {scope: "source.fxscript",
   name: "if ... else ... end",
   content: 
    "if (${1:Condition})\n\t${2:${TM_SELECTED_TEXT/(.*)$/$1/: // code}}\nelse ${3:if (${4:condition})}\n\t${5: // code}\nend if\n"},
 "line" => 
  {scope: "source.fxscript",
   name: "line",
   content: "Line(${1:p1}, ${2:p2}, ${3:image}, ${4:color}, ${5:width});"},
 "framepoly" => 
  {scope: "source.fxscript",
   name: "FramePoly",
   content: "FramePoly(${1:poly}, ${2:image}, ${3:color}, ${4:width});"},
 "levelmap" => 
  {scope: "source.fxscript",
   name: "LevelMap",
   content: 
    "LevelMap(${1:src}, ${2:dest}, ${3:alphaMap[256]}, ${4:redMap[256]}, ${5:greenMap[256]}, ${6:blueMap[256]});"},
 "colorof" => 
  {scope: "source.fxscript",
   name: "ColorOf",
   content: "ColorOf(${1:image}, ${2:point}, ${3:color});"},
 "lighten" => 
  {scope: "source.fxscript",
   name: "Lighten",
   content: 
    "Lighten(${1:srcImage1}, ${2:srcImage2}, ${3:destImage}, ${4:amount}, ${5:kAlpha});"},
 "subtract" => 
  {scope: "source.fxscript",
   name: "Subtract",
   content: 
    "Subtract(${1:srcImage1}, ${2:srcImage2}, ${3:destImage}, ${4:amount}, ${5:kAlpha});"},
 "darken" => 
  {scope: "source.fxscript",
   name: "Darken",
   content: 
    "Darken(${1:srcImage1}, ${2:srcImage2}, ${3:destImage}, ${4:amount}, ${5:kAlpha});"}}
