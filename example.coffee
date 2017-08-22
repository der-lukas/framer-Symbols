# MODULE IMPORT
{Symbol} = require 'Symbol'

# COMMON STATES FOR ALL BUTTON-SYMBOLS
buttonStates =
	active:
		template: button_active
	disabled:
		template: button_disabled
		animationOptions:
			curve: Spring(damping: 1)
			time: 0.7
			

# INITIATE BUTTON SYMBOL
Button = new Symbol(buttonTemplate)

# CREATE BUTTON INSTANCE
btn = new Button
	parent: home
	x: Align.center
	y: Align.center

# ADD A SPECIFIC STATE TO THIS BUTTON-INSTANCE
btn.addSymbolState('special', button_special)

# APPLY STATE ANIMATION OPTIONS IF NECESSARY
btn.states.animationOptions =
	curve: Spring

# CYCLE BETWEEN STATES ON CLICK
btn.onClick ->
	@.stateCycle()
