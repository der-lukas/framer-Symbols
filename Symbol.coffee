exports.createSymbol = (layer) ->
  class Temp extends Layer
    constructor: (options={}) ->
      options.backgroundColor ?= layer.backgroundColor
      options.image ?= layer.image
      options.opacity ?= layer.props.opacity
      options.borderWidth ?= layer.props.borderWidth
      options.borderColor ?= layer.props.borderColor
      options.borderRadius ?= layer.props.borderRadius
      options.shadowSpread ?= layer.props.shadowSpread
      options.shadowX ?= layer.props.shadowX
      options.shadowY ?= layer.props.shadowY
      options.shadowBlur ?= layer.props.shadowBlur
      options.shadowColor ?= layer.props.shadowColor
      options.scale ?= layer.props.scale
      options.scaleX ?= layer.props.scaleX
      options.scaleY ?= layer.props.scaleY
      options.rotation ?= layer.props.rotation
      options.rotationX ?= layer.props.rotationX
      options.rotationY ?= layer.props.rotationY
      options.originX ?= layer.props.originX
      options.originY ?= layer.props.originY
      options.skewX ?= layer.props.skewX
      options.skewY ?= layer.props.skewY

      options.x ?= false
      options.y ?= false

      super options

      @.props = layer.props

      @.name = options.name
      @.size = options.size
      @.image = options.image
      @.backgroundColor = options.backgroundColor
      @.opacity = options.opacity
      @.borderWidth = options.borderWidth
      @.borderColor = options.borderColor
      @.borderRadius = options.borderRadius
      @.shadowSpread = options.shadowSpread
      @.shadowX = options.shadowX
      @.shadowY = options.shadowY
      @.shadowBlur = options.shadowBlur
      @.shadowColor = options.shadowColor
      @.scale = options.scale
      @.scaleX = options.scaleX
      @.scaleY = options.scaleY
      @.rotation = options.rotation
      @.rotationX = options.rotationX
      @.rotationY = options.rotationY
      @.originX = options.originX
      @.originY = options.originY
      @.skewX = options.skewX
      @.skewY = options.skewY

      @.x = options.x
      @.y = options.y

      @.customProps = options.customProps

      for subLayer in layer.descendants
        if subLayer.children.length > 0
          @[subLayer.name] = new Layer
          @[subLayer.name].props = subLayer.props
          @[subLayer.name].name = subLayer.name
          @[subLayer.name].parent = @
          for child in subLayer.children
            if child.__framerInstanceInfo.framerClass == "TextLayer"
              @[child.name] = new TextLayer

              @[child.name].props = child.props
              @[child.name].name = child.name
              @[child.name].parent = @[subLayer.name]
              @[child.name].textAlign = child.props.styledTextOptions.alignment
            else if child.__framerInstanceInfo.framerClass == "SVGLayer"
              @[child.name] = new SVGLayer

              @[child.name]._DefinedPropertiesValuesKey =  child._DefinedPropertiesValuesKey
              @[child.name]._element = child._element
              @[child.name]._elementHTML = child._elementHTML
              @[child.name].props = child.props

              @[child.name].name = child.name
              @[child.name].parent = @[subLayer.name]
            else
              @[child.name] = new Layer

              @[child.name].props = child.props
              @[child.name].name = child.name
              @[child.name].parent = @[subLayer.name]
        else if subLayer.parent is layer
          if subLayer.__framerInstanceInfo.framerClass == "TextLayer"
            @[subLayer.name] = new TextLayer

            @[subLayer.name].props = subLayer.props
            @[subLayer.name].name = subLayer.name
            @[subLayer.name].parent = @
            @[subLayer.name].textAlign = subLayer.props.styledTextOptions.alignment
          else if subLayer.__framerInstanceInfo.framerClass == "SVGLayer"
            @[subLayer.name] = new SVGLayer
            @[subLayer.name].backgroundColor = null
            @[subLayer.name].width = null
            @[subLayer.name].height = null

            @[subLayer.name]._DefinedPropertiesValuesKey =  subLayer._DefinedPropertiesValuesKey
            @[subLayer.name]._element = subLayer._element
            @[subLayer.name]._elementHTML = subLayer._elementHTML
            @[subLayer.name].props = subLayer.props

            @[subLayer.name].name = subLayer.name
            @[subLayer.name].parent = @
          else
            @[subLayer.name] = new Layer

            @[subLayer.name].props = subLayer.props
            @[subLayer.name].name = subLayer.name
            @[subLayer.name].parent = @

      @.on Events.StateSwitchStart, (from, to) ->
        for child in @.subLayers
          if child.constructor.name == "TextLayer"
            child.states[to].text = child.text

            if Object.keys(child.template).length > 0
              child.states[to].template = child.template
          else
            if child.image && (child.states[to].image != child.image)
              child.states[to].image = child.image

          child.stateCycle(to)

    addSymbolState: (stateName, target) ->
      @.states["#{stateName}"] =
          backgroundColor: target.states["default"].backgroundColor
          opacity: target.states["default"].opacity
          borderWidth: target.states["default"].borderWidth
          borderColor: target.states["default"].borderColor
          borderRadius: target.states["default"].borderRadius
          shadowSpread: target.states["default"].shadowSpread
          shadowX: target.states["default"].shadowX
          shadowY: target.states["default"].shadowY
          shadowBlur: target.states["default"].shadowBlur
          shadowColor: target.states["default"].shadowColor
          scale: target.states["default"].scale
          scaleX: target.states["default"].scaleX
          scaleY: target.states["default"].scaleY
          rotation: target.states["default"].rotation
          rotationX: target.states["default"].rotationX
          rotationY: target.states["default"].rotationY
          originX: target.states["default"].originX
          originY: target.states["default"].originY
          skewX: target.states["default"].skewX
          skewY: target.states["default"].skewY

      for child in @.subLayers
        child.states["#{stateName}"] = target.childrenWithName(child.name)[0].states["default"]

      target.destroy()

    layer.destroy()
