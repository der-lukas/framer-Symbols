###
For this snippet to work, go into Design-Mode and create
3 buttons called "button_default", "button_disabled" and "button_active"
– these will get merged into one symbol!
###

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
buttonInstance = new Button
	x: Align.center
	y: 100

# CYCLE BETWEEN STATES ON CLICK
buttonInstance.onClick ->
	@.stateCycle()
