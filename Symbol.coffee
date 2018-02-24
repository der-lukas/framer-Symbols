removeIds = (htmlString) ->
	ids = Utils.getIdAttributesFromString(htmlString)
	for id in ids
		htmlString = htmlString.replace(/ id="(.*?)"/g, "") ;
	return htmlString

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

copyStatesFromTarget = (source, target, stateName, animationOptions = false) ->
	targets = []

	for layer in target.descendants
		targets[layer.name] = layer

	for subLayer in source.descendants
		if subLayer.constructor.name is "SVGLayer"
			delete targets[subLayer.name].states["default"].html

		if subLayer.constructor.name is "SVGPath" or subLayer.constructor.name is "SVGGroup"
			subLayer._svgLayer.states["#{stateName}"] = targets[subLayer.name]._svgLayer.states["default"]

		subLayer.states["#{stateName}"] = targets[subLayer.name].states["default"]

		if animationOptions
			subLayer.states["#{stateName}"].animationOptions = animationOptions

Layer::addSymbolState = (stateName, target, animationOptions = false) ->
	if stateName isnt "default"
		delete target.states.default[prop] for prop in ['x', 'y']
		@.states["#{stateName}"] = target.states.default

	if animationOptions
		@.states["#{stateName}"].animationOptions = animationOptions

	copyStatesFromTarget(@, target, stateName, animationOptions)

Layer::replaceWithSymbol = (symbol) ->
	symbol.parent = @.parent
	symbol.x = @.x
	symbol.y = @.y

	for stateName in symbol.stateNames
		symbol.states["#{stateName}"].x = @.x
		symbol.states["#{stateName}"].y = @.y

	@.destroy()

exports.Symbol = (layer, states = false, events = false) ->
	class Symbol extends Layer
		constructor: (@options = {} ) ->
			super _.defaults @options, layer.props

			for child in layer.descendants
				@[child.name] = child

				for key, props of @options
					if key is child.name
						for prop, value of props
							@[key][prop] = value

			# delete @.states.default[prop] for prop in ['x', 'y']

			@.customProps = @options.customProps

			copySourceToTarget(layer, @)

			@.addSymbolState('default', layer, false)

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

			# Prevent weird glitches by switching to "default" state directly
			for child in @.descendants
				child.stateSwitch "default"

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

		# Destroy template layers
		layer.destroy()

		if states
			for stateName, stateProps of states
				stateProps.template.destroy()

# A backup for the deprecated way of calling the class
exports.createSymbol = (layer, states, events) -> exports.Symbol(layer, states, events)
