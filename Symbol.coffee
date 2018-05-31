# Removes IDs from SVG
removeIds = (htmlString) ->
  ids = Utils.getIdAttributesFromString(htmlString)
  for id in ids
    htmlString = htmlString.replace(/ id="(.*?)"/g, "") ;
  return htmlString

# Copies all descendants of a layer
copySourceToTarget = (source, target = false) ->
  if source.children.length > 0
    for subLayer in source.descendants
      if subLayer.constructor.name is "SVGLayer"
        if subLayer.html? and subLayer.svg?
          delete subLayer.svg
        subLayer.html = removeIds(subLayer.html)
        target[subLayer.name] = subLayer.copy()
      else if subLayer.constructor.name is "SVGPath" or subLayer.constructor.name is "SVGGroup"
        svgCopy = subLayer._svgLayer.copy()
        target[subLayer.name] = svgCopy
      else
        target[subLayer.name] = subLayer.copySingle()

      target[subLayer.name].name = subLayer.name

      if subLayer.parent is source
        target[subLayer.name].parent = target
      else
        target[subLayer.name].parent = target[subLayer.parent.name]

      if target[subLayer.name].constructor.name isnt "SVGLayer"
        target[subLayer.name].constraintValues = subLayer.constraintValues
        target[subLayer.name].layout()

      # Create reference to the symbol instance
      target[subLayer.name]._instance = target

# Copies default-state of target and applies it to the symbol's descendants
copyStatesFromTarget = (source, target, stateName, animationOptions = false, ignoredProps = false, stateProps = false) ->
  targets = []

  for layer in target.descendants
    if layer.constraintValues
      layer.frame = Utils.calculateLayoutFrame(layer.parent.frame, layer)
    targets[layer.name] = layer

  for subLayer in source.descendants
    if subLayer.constructor.name is "SVGLayer"
      delete targets[subLayer.name].states.default.html

    if subLayer.constructor.name is "SVGPath" or subLayer.constructor.name is "SVGGroup"
      subLayer._svgLayer.states["#{stateName}"] = targets[subLayer.name]._svgLayer.states.default

    if ignoredProps
      # Change the props of the descendants of a symbol inside commonStates
      for ignoredProp, ignoredVal of ignoredProps
        if targets[subLayer.name].name is ignoredProp
          for descendantProp, descendantVal of ignoredVal
            targets[subLayer.name].states.default[descendantProp] = descendantVal

    if stateProps
      # Change the props of the descendants of a symbol inside commonStates
      for stateProp, stateVal of stateProps
        if targets[subLayer.name].name is stateProp
          for descendantProp, descendantVal of stateVal
            targets[subLayer.name].states.default[descendantProp] = descendantVal

    if stateName isnt "default" or (subLayer.constructor.name is "SVGPath" or subLayer.constructor.name is "SVGGroup" or subLayer.constructor.name is "SVGLayer")
      subLayer.states["#{stateName}"] = targets[subLayer.name].states.default

    if animationOptions
      subLayer.states["#{stateName}"].animationOptions = animationOptions

      # Also add the animationOptions to the "parent" SVGLayer of a SVGPath or SVGGroup
      if subLayer.constructor.name is "SVGPath" or subLayer.constructor.name is "SVGGroup"
        subLayer._svgLayer.states["#{stateName}"].animationOptions = animationOptions

    if targets[subLayer.name].constructor.name isnt "SVGPath" or targets[subLayer.name].constructor.name isnt "SVGGroup"
      targets[subLayer.name].layout()

  target.destroy()

Layer::replaceWithSymbol = (symbol) ->
  Utils.throwInStudioOrWarnInProduction "Error: layer.replaceWithSymbol(symbolInstance) is deprecated - use symbolInstance.replaceLayer(layer) instead."
  # symbol.replaceLayer @

exports.Symbol = (layer, states = false, events = false) ->
  class Symbol extends Layer
    constructor: (@options = {}) ->
      @options.x ?= 0
      @options.y ?= 0
      @options.replaceLayer ?= false
      @options.initialState ?= false

      blacklist = ['parent', 'replaceLayer']
      @.ignoredProps = {}

      for key, val of @options
        @.ignoredProps[key] = val

      for prop in blacklist
        delete @.ignoredProps[prop]

      super _.defaults @options, layer.props

      @.customProps = @options.customProps
      @.initialState = @options.initialState

      copySourceToTarget(layer, @)
      copyStatesFromTarget(@, layer, 'default', false, @.ignoredProps)

      if @options.replaceLayer
        @.replaceLayer @options.replaceLayer

      for child in @.descendants
        @[child.name] = child

        for key, props of @options
          if key is child.name
            for prop, value of props
              @[key][prop] = value

      # Apply states to symbol if supplied
      if states
        newStates = _.cloneDeep(states)
        for stateName, stateProps of newStates
          # Filter animationOptions out of states and apply them to symbol
          if stateName is "animationOptions"
            @.animationOptions = stateProps
            for descendant in @.descendants
              descendant.animationOptions = @.animationOptions
          else
            if !stateProps.template
              stateProps.template = layer

            @.addSymbolState(stateName, stateProps.template, stateProps.animationOptions, @.ignoredProps, stateProps)

      # Apply events to symbol if supplied
      if events
        for trigger, action of events
          # if event listener is applied to the symbol-instance
          if _.isFunction(action)
            if Events[trigger]
              @on Events[trigger], action
          # if event listener is applied to a symbol's descendant
          else
            if @[trigger]
              for triggerName, actionProps of action
                if Events[triggerName]
                  @[trigger].on Events[triggerName], actionProps

      # Prevent weird glitches by switching SVGs to "default" state directly
      for child in @.descendants
        if child.constructor.name is "SVGLayer" or child.constructor.name is "SVGPath" or child.constructor.name is "SVGGroup"
          child.stateSwitch "default"

      # Handle the stateSwitch for all descendants
      @.on Events.StateSwitchStart, (from, to) ->
        if from is to
          return

        for child in @.descendants
          # Special handling for TextLayers
          if child.constructor.name is "TextLayer"
            child.states[to].text = child.text
            child.states[to].textAlign = child.props.styledTextOptions.alignment

            if child.template and Object.keys(child.template).length > 0
              child.states[to].template = child.template

          else
            if child.image and (child.states[to].image isnt child.image)
              child.states[to].image = child.image

          # Kickstart the stateSwitch
          child.animate to

      # Destroy state template layers
      if states
        for stateName, stateProps of states
          if stateProps.template
            stateProps.template.destroy()

      layer.destroy()

      # If there's an initial state defined, switch to it
      if @options.initialState
        if @.states[@options.initialState]
          @.stateSwitch @options.initialState
        else
          Utils.throwInStudioOrWarnInProduction "The supplied initialState '#{@options.initialState}' is undefined"

    # Adds a new state
    addSymbolState: (stateName, target, animationOptions = false, ignoredProps = false, stateProps = false) ->
      newTarget = target.copy()
      targets = []

      for descendant in target.descendants
        targets[descendant.name] = descendant

      for descendant in newTarget.descendants
        descendant.constraintValues = targets[descendant.name].constraintValues
        if descendant.constructor.name is "SVGPath" or descendant.constructor.name is "SVGGroup"
          descendant.states.default = targets[descendant.name].states.default

      # Resize the template before using its values to respect constraint-changes
      if ignoredProps.width
        newTarget.width = ignoredProps.width
      if ignoredProps.height
        newTarget.height = ignoredProps.height

      # Delete x,y props from templates default state
      delete newTarget.states.default[prop] for prop in ['x', 'y']

      # Apply all other props that should stay the same for all states
      if ignoredProps
        delete newTarget.states.default[prop] for prop of ignoredProps

      if stateProps.width
        newTarget.width = stateProps.width
      if stateProps.height
        newTarget.height = stateProps.height

      if stateProps
        # Change the props of a symbol inside commonStates
        for stateProp, stateVal of stateProps
          # Check if it's a property
          if typeof newTarget.props[stateProp] isnt 'undefined'
            newTarget.states.default[stateProp] = stateVal

            delete stateProps[stateProp]

      # Create a new state for the symbol and assign remaining props
      @.states["#{stateName}"] = newTarget.states.default

      # Assign animationOptions to the state if supplied
      if animationOptions
        @.states["#{stateName}"].animationOptions = animationOptions

      copyStatesFromTarget(@, newTarget, stateName, animationOptions, ignoredProps, stateProps)

    # Override original stateSwitch to make it work with symbols
    stateSwitch: (stateName) ->

      # Make backup of the original animation time
      if @.states[stateName].animationOptions
        animTime = @.states[stateName].animationOptions.time
        animCurve = @.states[stateName].animationOptions.curve
      else
        animTime = @.states.animationOptions.time
        animCurve = @.states.animationOptions.curve

      # Set the animation time of all symbol layers to zero
      for desc in @.descendants
        if desc.states[stateName].animationOptions
          desc.states[stateName].animationOptions.time = 0.05
          desc.states[stateName].animationOptions.curve = "linear"
        else
          desc.states.animationOptions.time = 0.05
          desc.states.animationOptions.curve = "linear"

      # Trigger the stateSwitch
      @.animate stateName,
        time: 0.05
        curve: "linear"

      # Reset the animation time to the original time
      for desc in @.descendants
        if desc.states[stateName].animationOptions
          desc.states[stateName].animationOptions.time = animTime
          desc.states[stateName].animationOptions.curve = animCurve
        else
          desc.states.animationOptions.time = animTime
          desc.states.animationOptions.curve = animCurve

    # Replacement for replaceWithSymbol()
    replaceLayer: (layer, resize = false) ->
      @.parent = layer.parent
      @.x = layer.x
      @.y = layer.y

      if resize
        @.width = layer.width
        @.height = layer.height

      for stateName in @.stateNames
        @.states[stateName].x = layer.x
        @.states[stateName].y = layer.y

        if resize
          @.states[stateName].width = layer.width
          @.states[stateName].height = layer.height

      layer.destroy()

# A backup for the deprecated way of calling the class
exports.createSymbol = (layer, states, events) -> exports.Symbol(layer, states, events)
