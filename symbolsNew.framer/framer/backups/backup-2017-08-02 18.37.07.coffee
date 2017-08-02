{createSymbol} = require 'Symbol'

gap = 20

scroll = new ScrollComponent
	size: Screen.size
	scrollHorizontal: false
	parent: home

scroll.contentInset =
	top: 80
	bottom: 20

Card = createSymbol(cardTemplate, true)

for i in [0..5]
	card = new Card
		name: "lala" + i
		parent: scroll.content
# 		backgroundColor: Utils.randomColor()
		x: Align.center
		y: (180 + gap) * i
		customProps: 
			active: false
	
	card.title.template = 
		temp: "🤘"
		lala: "#{i}"
	
	card.states.animationOptions =
		curve: Spring
	
	card.addSymbolState('inactive', cardTemplate_Inactive)
	card.addSymbolState('active', cardTemplate_Active)

	card.icon.backgroundColor = Utils.randomColor()
	card.subtitle.text = "Subtitle " + (i + 1)
	
	card.onClick ->
# 		print @.title.template.index
		@.stateCycle('inactive', 'active')

# BUTTON SYMBOL

Button = createSymbol(button, true)

btn = new Button
	parent: home
	x: Align.center
	y: 20

btn.buttonLabel.template = "🤘"

btn.addSymbolState('disabled', button_disabled)

btn.states.animationOptions =
	curve: Spring

btn.onClick ->
	btn.stateCycle('default','disabled')

btn.bringToFront()
