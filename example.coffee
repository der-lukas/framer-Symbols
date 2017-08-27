# Create common states (optional)
commonStates =
	disabled:
		template: button_disabled
		animationOptions:
			curve: Spring(damping: 1)
			time: 0.7
	active:
		template: button_active
		animationOptions:
			curve: Bezier.easeInOut
			time: 1

# Initialize your symbol
# ("button_default" needs to be created either in Design or Code-Mode)
Button = new Symbol(button_default, commonStates)

# Create instances of your symbol
buttonInstanceOne = new Button
	x: Align.center
	y: 100

buttonInstanceTwo = new Button
	x: Align.center
	y: 200

# CYCLE BETWEEN STATES ON CLICK
btn.onClick ->
	@.stateCycle()
