# MODULE IMPORT
{createSymbol} = require 'Symbol'

# BUTTON SYMBOL (needs to be created in Design Mode)
Button = createSymbol(button)

# CREATE BUTTON INSTANCE
btn = new Button
	parent: home
	x: Align.center
	y: Align.center

# ADD BUTTON STATES (need to be created in Design Mode)
btn.addSymbolState('disabled', button_disabled)
btn.addSymbolState('active', button_active)

# APPLY STATE ANIMATION OPTIONS IF NECESSARY
btn.states.animationOptions =
	curve: Spring

# CYCLE BETWEEN STATES ON CLICK
btn.onClick ->
	@.stateCycle()
