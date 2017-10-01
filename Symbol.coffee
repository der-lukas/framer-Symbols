copySourceToTarget = (source, target=false) ->
  if source.children.length > 0
    for subLayer in source.descendants
      target[subLayer.name] = subLayer.copySingle()
      target[subLayer.name].name = subLayer.name

      if subLayer.parent is source
        target[subLayer.name].parent = target
      else
        target[subLayer.name].parent = target[subLayer.parent.name]

copyStatesFromTarget = (source, target, stateName, animationOptions=false) ->
  targets = []

  for layer in target.descendants
    targets[layer.name] = layer

  for subLayer in source.descendants
    subLayer.states["#{stateName}"] = targets[subLayer.name].states["default"]

    if animationOptions
      subLayer.states["#{stateName}"].animationOptions = animationOptions

Layer::addSymbolState = (stateName, target, animationOptions=false) ->
  @.states["#{stateName}"] =
      width: target.states["default"].width
      height: target.states["default"].height
      visible: target.states["default"].visible
      opacity: target.states["default"].opacity
      clip: target.states["default"].clip
      scrollHorizontal: target.states["default"].scrollHorizontal
      scrollVertical: target.states["default"].scrollVertical
      scroll: target.states["default"].scroll
      scaleX: target.states["default"].scaleX
      scaleY: target.states["default"].scaleY
      scaleZ: target.states["default"].scaleZ
      scale: target.states["default"].scale
      skewX: target.states["default"].skewX
      skewY: target.states["default"].skewY
      skew: target.states["default"].skew
      originX: target.states["default"].originX
      originY: target.states["default"].originY
      originZ: target.states["default"].originZ
      perspective: target.states["default"].perspective
      perspectiveOriginX: target.states["default"].perspectiveOriginX
      perspectiveOriginY: target.states["default"].perspectiveOriginY
      rotationX: target.states["default"].rotationX
      rotationY: target.states["default"].rotationY
      rotationZ: target.states["default"].rotationZ
      rotation: target.states["default"].rotation
      blur: target.states["default"].blur
      brightness: target.states["default"].brightness
      saturate: target.states["default"].saturate
      hueRotate: target.states["default"].hueRotate
      contrast: target.states["default"].contrast
      invert: target.states["default"].invert
      grayscale: target.states["default"].grayscale
      sepia: target.states["default"].sepia
      blending: target.states["default"].blending
      backgroundBlur: target.states["default"].backgroundBlur
      backgroundBrightness: target.states["default"].backgroundBrightness
      backgroundSaturate: target.states["default"].backgroundSaturate
      backgroundHueRotate: target.states["default"].backgroundHueRotate
      backgroundContrast: target.states["default"].backgroundContrast
      backgroundInvert: target.states["default"].backgroundInvert
      backgroundGrayscale: target.states["default"].backgroundGrayscale
      backgroundSepia: target.states["default"].backgroundSepia
      shadows: target.states["default"].shadows
      backgroundColor: target.states["default"].backgroundColor
      color: target.states["default"].color
      borderRadius: target.states["default"].borderRadius
      borderColor: target.states["default"].borderColor
      borderWidth: target.states["default"].borderWidth
      borderStyle: target.states["default"].borderStyle
      force2d: target.states["default"].force2d
      flat: target.states["default"].flat
      backfaceVisible: target.states["default"].backfaceVisible
      htmlIntrinsicSize: target.states["default"].htmlIntrinsicSize
      html: target.states["default"].html
      image: target.states["default"].image
      gradient: target.states["default"].gradient
      scrollX: target.states["default"].scrollX
      scrollY: target.states["default"].scrollY

  if animationOptions
    @.states["#{stateName}"].animationOptions = animationOptions

  copyStatesFromTarget(@, target, stateName, animationOptions)
  target.destroy()

Layer::replaceWithSymbol = (symbol) ->
  symbol.point = @.point
  symbol.parent = @.parent

  for stateName in symbol.stateNames
    symbol.states["#{stateName}"].point = @.point
  @.destroy()

exports.Symbol = (layer, states=false, events=false) ->
  class Symbol extends Layer
    constructor: (@options={}) ->
      @options.width ?= layer.width
      @options.height ?= layer.height
      @options.visible ?= layer.visible
      @options.opacity ?= layer.opacity
      @options.clip ?= layer.clip
      @options.scrollHorizontal ?= layer.scrollHorizontal
      @options.scrollVertical ?= layer.scrollVertical
      @options.scroll ?= layer.scroll
      @options.x ?= layer.x
      @options.y ?= layer.y
      @options.z ?= layer.z
      @options.scaleX ?= layer.scaleX
      @options.scaleY ?= layer.scaleY
      @options.scaleZ ?= layer.scaleZ
      @options.scale ?= layer.scale
      @options.skewX ?= layer.skewX
      @options.skewY ?= layer.skewY
      @options.skew ?= layer.skew
      @options.originX ?= layer.originX
      @options.originY ?= layer.originY
      @options.originZ ?= layer.originZ
      @options.perspective ?= layer.perspective
      @options.perspectiveOriginX ?= layer.perspectiveOriginX
      @options.perspectiveOriginY ?= layer.perspectiveOriginY
      @options.rotationX ?= layer.rotationX
      @options.rotationY ?= layer.rotationY
      @options.rotationZ ?= layer.rotationZ
      @options.rotation ?= layer.rotation
      @options.blur ?= layer.blur
      @options.brightness ?= layer.brightness
      @options.saturate ?= layer.saturate
      @options.hueRotate ?= layer.hueRotate
      @options.contrast ?= layer.contrast
      @options.invert ?= layer.invert
      @options.grayscale ?= layer.grayscale
      @options.sepia ?= layer.sepia
      @options.blending ?= layer.blending
      @options.backgroundBlur ?= layer.backgroundBlur
      @options.backgroundBrightness ?= layer.backgroundBrightness
      @options.backgroundSaturate ?= layer.backgroundSaturate
      @options.backgroundHueRotate ?= layer.backgroundHueRotate
      @options.backgroundContrast ?= layer.backgroundContrast
      @options.backgroundInvert ?= layer.backgroundInvert
      @options.backgroundGrayscale ?= layer.backgroundGrayscale
      @options.backgroundSepia ?= layer.backgroundSepia
      @options.shadows ?= layer.shadows
      @options.backgroundColor ?= layer.backgroundColor
      @options.color ?= layer.color
      @options.borderRadius ?= layer.borderRadius
      @options.borderColor ?= layer.borderColor
      @options.borderWidth ?= layer.borderWidth
      @options.borderStyle ?= layer.borderStyle
      @options.force2d ?= layer.force2d
      @options.flat ?= layer.flat
      @options.backfaceVisible ?= layer.backfaceVisible
      @options.htmlIntrinsicSize ?= layer.htmlIntrinsicSize
      @options.html ?= layer.html
      @options.image ?= layer.image
      @options.gradient ?= layer.gradient
      @options.scrollX ?= layer.scrollX
      @options.scrollY ?= layer.scrollY

      @options.x ?= false
      @options.y ?= false

      super @options

      @.customProps = @options.customProps

      @.states['default'].x = @.x
      @.states['default'].y = @.y

      copySourceToTarget(layer, @)

      if states
        for stateName, stateProps of states
          @.addSymbolState(stateName, stateProps.template, stateProps.animationOptions)

      if events
        for trigger, action of events
          if _.isFunction(action)
            if Events[trigger]
              @on Events[trigger], action
          else
            if @[trigger]
              for triggerName, actionProps of action
                if Events[triggerName]
                  @[trigger].on Events[triggerName], actionProps

      @.on Events.StateSwitchStart, (from, to) ->
        for child in @.descendants
          if child.constructor.name == "TextLayer"
            child.states[to].text = child.text
            child.states[to].textAlign = child.props.styledTextOptions.alignment
            child.states[to].width = child.width
            child.states[to].height = child.height

            if child.template && Object.keys(child.template).length > 0
              child.states[to].template = child.template

          else
            if child.image && (child.states[to].image != child.image)
              child.states[to].image = child.image

          child.animate to

    layer.destroy()

# A backup for the deprecated way of calling the class
exports.createSymbol = (layer, states) -> exports.Symbol(layer, states)
