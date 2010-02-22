# Encoding: UTF-8

{fileTypes: ["fxscript"],
 foldingStartMarker: /(?<_1>^|(?<=;)[ \t]*)on[ \t]+(?<_2>\w+)[ \t]*/,
 foldingStopMarker: /end(?<_1>;|;?[ \t]*|;?[ \t]*\/\/.*[ \t]*)/,
 keyEquivalent: "^~F",
 name: "FXScript",
 patterns: 
  [{begin: /(?<_1>^|(?<=;)[ \t]*)on[ \t]+(?<_2>\w+)[ \t]*(?=\([^\)]*\))/,
    captures: {2 => {name: "entity.name.function.fxscript"}},
    end: "end(;|;?[ \\t]*\\n|;?[ \\t]*//.*[ \\t]*\\n)",
    name: "meta.function.fxscript",
    patterns: 
     [{begin: /\((?=(?i:clip|color|float|image|point|string|value|point3d))/,
       end: "\\)",
       patterns: 
        [{captures: 
           {1 => {name: "support.type.fxscript"},
            2 => {name: "variable.parameter.function.fxscript"}},
          match: 
           /(?<_1>(?i:clip|color|float|image|point|string|value|point3d))[ \t]+(?<_2>[^,)]+)/}]},
      {include: "$self"}]},
   {begin: /(?<_1>^|(?<=;)[ \t]*)input[ \t]*/,
    comment: "Input Controls",
    end: "\\n",
    name: "keyword.other.input-control.fxscript",
    patterns: 
     [{include: "$self"},
      {captures: 
        {1 => {name: "variable.other.global.fxscript"},
         2 => {name: "string.quoted.double.fxscript"},
         3 => {name: "support.type.fxscript"}},
       match: 
        /\b(?<_1>\w+),[ \t]+(?<_2>"[^"]+"),[ \t]+(?i:Angle|CheckBox|Clip|Color|FontList|Label|Point|Popup|RadioGroup|Slider|Text),?/}]},
   {comment: "Data Types",
    match: /(?i:float|image|point|point3d|region|string|value|YUVcolor)\b/,
    name: "storage.type.fxscript"},
   {match: 
     /\b(?i:if|(?<_1>end|else)(?<_2> if)?|for|next|return|repeat(?<_3> While| With (?<_4>Counter|List)))\b/,
    name: "keyword.control.fxscrpt"},
   {match: 
     /\/b(?i:AlphaType|EffectID|FullFrame|Group|InformationFlag|InvalEntireItem|KeyType|ProducesAlpha|QTEffect|RenderEachFrameWhenStill|WipeCode)\/b/,
    name: "keyword.other.definition-statements.fxscript"},
   {match: 
     /!|\$|%|&|\*|\-\-|\-|\+\+|\+|~|==|=|!=|!==|<=|>=|<|>|!|&&|\|\||\?\:|\*=|\/=|%=|\+=|\-=|&=|\^=/,
    name: "keyword.operator.arithmetic.fxscrpt"},
   {captures: {1 => {name: "punctuation.definition.comment.fxscript"}},
    match: /(?<_1>\/\/).*$\n?/,
    name: "comment.line.double-slash.fxscript"},
   {match: /(?i:kFormatRGB219|kFormatRGB255|kFormatYUV219)/,
    name: "support.constant.colorspace.fxscript"},
   {match: /\b[0-9]+(?<_1>\.[0-9]*)?\b/, name: "constant.numeric.fxscript"},
   {match: /\b0x(?<_1>[a-fA-F0-9]*)?\b/,
    name: "constant.numeric.hex.fxscript"},
   {match: /(?i:kBlack|kBlue|kCyan|kGray|kGreen|kMagenta|kRed|kWhite|kYellow)/,
    name: "support.constant.color.fxscript"},
   {match: 
     /(?i:k16mm|k24fps|k25fps|k30df|k30fps|k35mm|k60df|k60fps|kFloat2|kFloat4|kFloat6|kInteger|kSize)/,
    name: "support.constant.formatting.fxscript"},
   {match: /(?i:false|kAlpha|kNone|kUndefined|true)\b/,
    name: "support.constant.general.fxscript"},
   {match: 
     /(?i:kKeyAdd|kKeyDarken|kKeyDifference|kKeyHardLight|kKeyLighten|kKeyMultiply|kKeyNormal|kKeyOverlay|kKeyScreen|kKeySoftLight|kKeySubtract)/,
    name: "support.constant.key.fxscript"},
   {match: 
     /(?i:k16mm|k24fps|k25fps|k30df|k30fps|k35mm|k60df|k60fps|kFloat2|kFloat4|kFloat6|kInteger|kSize)/,
    name: "support.constant.formatting.fxscript"},
   {match: 
     /\b(?i:clip1|clip2|dest|duration|exposedBackground|fieldNumber|fieldprocessing|fps|frame|linearRamp|previewing|ratio|renderRes|RGBtoYUV|src1|src2|srcIsGap1|srcIsGap2|srcType1|srcType2|topfield|YUVtoRGB)\b/,
    name: "support.variable.predeclared.fxscript"},
   {match: 
     /(?i:kbold|kbolditalic|kcenterjustify|kitalic|kleftjustify|kplain|krightjustify)/,
    name: "support.constant.text.fxscript"},
   {match: /(?i:kDiamond|kRound|kSquare)/,
    name: "support.constant.shapes.fxscript"},
   {captures: 
     {1 => {name: "entity.name.function.color.alpha.fxscript"},
      2 => {name: "entity.name.function.color.red.fxscript"},
      3 => {name: "entity.name.function.color.green.fxscript"},
      4 => {name: "entity.name.function.color.blue.fxscript"},
      5 => {name: "entity.name.function.color.luma.fxscript"},
      6 => {name: "entity.name.function.color.chroma-u.fxscript"},
      7 => {name: "entity.name.function.color.chroma-v.fxscript"}},
    match: 
     /\b\w+\.(?i:(?<_1>a)|(?<_2>r)|(?<_3>g)|(?<_4>b)|(?<_5>y)|(?<_6>u)|(?<_7>v))\b/},
   {begin: /"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.fxscript"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.fxscript"}},
    name: "string.quoted.double.fxscript",
    patterns: [{match: /\\./, name: "constant.character.escape.fxscript"}]},
   {match: 
     /\b(?i:Add|AddOffset|Darken|Difference|ImageAnd|ImageOr|ImageXor|Invert|InvertChannel|Lighten|Matte|Multiply|Overlay|Screen|Subtract|UnMultiply)\b/,
    name: "support.function.composite.fxscript"},
   {match: 
     /\b(?i:Blit|BlitRect|MaskCopy|MeshBlit|MeshBlit3D|PagePeel|RegionCopy)\b/,
    name: "support.function.blit.fxscript"},
   {match: /\b(?i:GetLimits|GetReelName|GetTimeCode|GetVideo)/,
    name: "support.function.clip.fxscript"},
   {match: 
     /\b(?i:BumpMap|Cylinder|Displace|Fisheye|OffsetPixels|PondRipple|Ripple|Wave|Whirlpool)\b/,
    name: "support.function.distort.fxscript"},
   {match: /\b(?i:Filter|Generator|Transition)\b/,
    name: "support.function.external.fxscript"},
   {match: 
     /\b(?i:AngleTo|AspectOf|BoundsOf|CenterOf|Convert2dto3d|convert3dto2d|DimensionsOf|DistTo|Grid|Interpolate|Mesh)\b/,
    name: "support.function.geometry.fxscript"},
   {match: /\b(?i:BGDiff|BlueScreen|GreenScreen|RGBColorKey|YUVColorKey)\b/,
    name: "support.function.key.fxscript"},
   {match: /\b(?i:Abs|Integer|Sign|Sqrt|Power)\b/,
    name: "support.function.math.fxscript"},
   {match: /\b(?i:BezToLevelMap|ChromaAngleKey)/,
    name: "support.function.parser.fxscript"},
   {match: 
     /\b(?i:Blend|Blur|BlurChannel|Channel(?<_1>Copy|Fill|Multiply)|ColorTransform|Convolve|Desaturate|Diffuse|DiffuseOffset|LevelMap|MotionBlur|RadialBlur)\b/,
    name: "support.function.process.fxscript"},
   {match: 
     /\b(?i:CurveTo|DrawSoftDot|FillArc|FillOval|FillPoly|FillRegion|FrameArc|FrameOval|FramePoly|FrameRegion|Line|MakeRect|MakeRegion|OvalRegion|RegionIsEmpty)\b/,
    name: "support.function.shapes.process.fxscript"},
   {match: 
     /\b(?i:ASCIIOf|ASCIIToSTring|CharsOf|CountTextLines|FindString|getTextLine|GetTimecodeStringFromClip|Length|NumToString|StringToNum)/,
    name: "support.function.string.fxscript"},
   {match: 
     /\b(?i:DrawString|DrawStringPlain|MeasureString|MeasureStringPlain|ResetText|SetTextFont|SetTextJustify|SetTextSize|SetTextStyle)/,
    name: "support.function.text.fxscript"},
   {match: /\b(?i:Offset|Offset3d|Outset3d|Rotate|Rotate3d|Scale|Scale3d)\b/,
    name: "support.function.transform.fxscript"},
   {match: 
     /\b(?i:getNativeAspect|getNativeSize|FilteredBlitRect|BlurChannel_alt)\b/,
    name: "support.function.undocumented.fxscript"},
   {match: /\b(?i:debugtext)\b/, name: "support.function.debug.fxscript"},
   {match: 
     /\b(?i:Assert|CircleLight|ColorOf|ConvertImage|GetConversionMatrix|GetPixelFormat|Highlight|MatrixConcat|PointTrack|Random(?<_1>Noise|Seed|Table)?|SetPixelFormat|SysTime|Truncate)\b/,
    name: "support.function.utility.fxscript"},
   {comment: 
     "Joe Maller’s personal FXScript Functions, these will be appearing on the FXScript Reference site someday.",
    match: 
     /\b(?<_1>(?i:absNoInt|ArrayFloatAbs|ArrayFloatAverage|ArrayFloatCount|ArrayFloatCountAll|ArrayFloatFlatten|ArrayFloatIndexExists|ArrayFloatInsertionSort|ArrayFloatMax|ArrayFloatMin|ArrayFloatNormalize|ArrayFloatPrint_r|ArrayFloatQuickSort|ArrayFloatSum|ArrayPointCount|ArrayPointReverse|ArrayPointWrap|BlurChannelInPlace|BoundsOfPoly|ceil|CenterOfPoly|ChannelCopyFit|ChannelMultiplyYUV|ChannelScreen|ChannelView|ColorRampImage|ColorReporter|DeInterlace|DeInterlaceFast|DeInterlaceInterpolate|DifferenceMask|DimensionsOfPoly|DrawGridFrames|ease|easeIn|easeMiddle|easeOut|easeS|ErrorReporter|factorial|factorialabsNoInt|FastRotate|FieldDouble|fitPoly|fitRange|fitRect|floor|gcd|getField|indexExistsPt|isFloatArray|isIndexFloat|isIndexFloatArray|makeLevelMapBez|makeThresholdMapBez|max|min|mirrorRect|NumReporter|PlaceFrame|PointInPoly|pt3dReporter|PtReporter|RandomNoiseScaled|RandomSeedFPS|RGBtoYUVcolor|round|scaleToFit|sumNaturals|T_borderFade|whattype|YUVtoRGBcolor))\b/,
    name: "support.function.joe.fxscript"}],
 scopeName: "source.fxscript",
 uuid: "43751327-3FD1-4BE7-AD05-136FC552BABA"}
