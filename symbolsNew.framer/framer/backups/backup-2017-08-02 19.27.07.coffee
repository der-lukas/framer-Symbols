{createSymbol} = require 'Symbol'

gap = 20

scroll = new ScrollComponent
	size: Screen.size
	scrollHorizontal: false
	parent: home

scroll.contentInset =
	top: 80
	bottom: 20

#CARD SYMBOL
Card = createSymbol(cardTemplate)

for i in [0..5]
	card = new Card
		name: "lala" + i
		parent: scroll.content
		x: Align.center
		y: (180 + gap) * i
		customProps: 
			active: false

	card.title.text = card.title.text + " " + (i+1)
	
	card.states.animationOptions =
		curve: Spring
	
	card.addSymbolState('disabled', cardTemplate_disabled)
	card.addSymbolState('active', cardTemplate_active)

	card.icon.backgroundColor = Utils.randomColor()
	card.subtitle.text = "Subtitle " + (i + 1)
	
	card.onClick ->
		@.stateCycle()

# BUTTON SYMBOL
Button = createSymbol(button)

btn = new Button
	parent: home
	x: Align.center
	y: 20

btn.buttonLabel.template = 
	label: btn.states.current.name
	emoji: "🤘"

btn.addSymbolState('disabled', button_disabled)
btn.addSymbolState('active', button_active)

btn.states.animationOptions =
	curve: Spring

btn.onClick ->
	@.stateCycle('default','disabled')
	for item in scroll.content.children
		print item
		item.stateCycle()
	
	if @.states.current.name == "default"
		@.buttonLabel.template = 
			label: @.states.current.name
			emoji: "🤘"
	else
		@.buttonLabel.template = 
			label: @.states.current.name
			emoji: "🙌"

btn.bringToFront()
