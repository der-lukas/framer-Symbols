exports.createSymbol = (layer) ->
  class Temp extends Layer
    constructor: (options={}) ->
      options.backgroundColor ?= layer.backgroundColor
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
      # @.image = options.image
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
            if child.constructor.name == "TextLayer"
              @[child.name] = new TextLayer

              @[child.name].props = child.props
              @[child.name].name = child.name
              @[child.name].parent = @[subLayer.name]
              @[child.name].textAlign = child.props.styledTextOptions.alignment
            else
              @[child.name] = new Layer

              @[child.name].props = child.props
              @[child.name].name = child.name
              @[child.name].parent = @[subLayer.name]
        else if subLayer.parent is layer
          if subLayer.constructor.name == "TextLayer"
            @[subLayer.name] = new TextLayer

            @[subLayer.name].props = subLayer.props
            @[subLayer.name].name = subLayer.name
            @[subLayer.name].parent = @
            @[subLayer.name].textAlign = subLayer.props.styledTextOptions.alignment
          else
            @[subLayer.name] = new Layer

            @[subLayer.name].props = subLayer.props
            @[subLayer.name].name = subLayer.name
            @[subLayer.name].parent = @

      @.on Events.StateSwitchStart, (from, to) ->
        for child in @.subLayers
          templateBackup = {}
          if child.constructor.name == "TextLayer"
            textBackup = child.text

            if Object.keys(child.template).length > 0
              templateBackup = child.template

          # child.stateCycle(to)
          child.stateSwitch(to)

      # @.on Events.AnimationEnd, (animation, layer) ->
        # print animation, layer
          if child.constructor.name == "TextLayer"
            child.template = templateBackup
            child.text = textBackup

    addSymbolState: (stateName, target) ->
      @.states["#{stateName}"] =
          backgroundColor: target.backgroundColor
          opacity: target.props.opacity
          borderWidth: target.props.borderWidth
          borderColor: target.props.borderColor
          borderRadius: target.props.borderRadius
          shadowSpread: target.props.shadowSpread
          shadowX: target.props.shadowX
          shadowY: target.props.shadowY
          shadowBlur: target.props.shadowBlur
          shadowColor: target.props.shadowColor
          scale: target.props.scale
          scaleX: target.props.scaleX
          scaleY: target.props.scaleY
          rotation: target.props.rotation
          rotationX: target.props.rotationX
          rotationY: target.props.rotationY
          originX: target.props.originX
          originY: target.props.originY
          skewX: target.props.skewX
          skewY: target.props.skewY

      for child in @.subLayers
        child.states["#{stateName}"] = target.childrenWithName(child.name)[0].states["default"]
          # backgroundColor: target.childrenWithName(child.name).backgroundColor
          # opacity: target.childrenWithName(child.name).props.opacity
          # borderWidth: target.childrenWithName(child.name).props.borderWidth
          # borderColor: target.childrenWithName(child.name).props.borderColor
          # borderRadius: target.childrenWithName(child.name).props.borderRadius
          # shadowSpread: target.childrenWithName(child.name).props.shadowSpread
          # shadowX: target.childrenWithName(child.name).props.shadowX
          # shadowY: target.childrenWithName(child.name).props.shadowY
          # shadowBlur: target.childrenWithName(child.name).props.shadowBlur
          # shadowColor: target.childrenWithName(child.name).props.shadowColor
          # scale: target.childrenWithName(child.name).props.scale
          # scaleX: target.childrenWithName(child.name).props.scaleX
          # scaleY: target.childrenWithName(child.name).props.scaleY
          # rotation: target.childrenWithName(child.name).props.rotation
          # rotationX: target.childrenWithName(child.name).props.rotationX
          # rotationY: target.childrenWithName(child.name).props.rotationY
          # originX: target.childrenWithName(child.name).props.originX
          # originY: target.childrenWithName(child.name).props.originY
          # skewX: target.childrenWithName(child.name).props.skewX
          # skewY: target.childrenWithName(child.name).props.skewY

      target.destroy()

    layer.destroy()
