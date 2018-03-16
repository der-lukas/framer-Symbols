###
For this snippet to work, go into Design-Mode and create
3 buttons called "button_default", "button_hover" and "button_active"
– these will get merged into one symbol!
###

# Create common states (optional)
commonStates =
	animationOptions: # These animationOptions will apply to all states
		curve: Spring(damping: 1)
		time: 0.7
	hover:
		template: button_hover
	active:
		template: button_active
		animationOptions: # These animationOptions apply to the 'active'-state
			curve: Bezier.easeInOut
			time: 1

# Create common events (optional)
commonEvents =
	MouseOver: -> @.animate 'hover'
	MouseOut: -> @.animate 'default'
	TapStart: -> @.animate 'active'
	TapEnd: -> @.animate 'hover'

# Initialize your symbol
# ("button_default" needs to be created either in Design or Code-Mode)
Button = Symbol(button_default, commonStates, commonEvents)

# Create instances of your symbol
buttonInstance = new Button
	x: Align.center
	y: 100

# CYCLE BETWEEN STATES ON CLICK
buttonInstance.onClick ->
	@.stateCycle()
