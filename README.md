# framer-Symbols
A module to create symbols[*](#-pssst-it-actually-is-a-class) in Framer

![framerdemo](https://dr5mo5s7lqrtc.cloudfront.net/items/3z2z2A3P353E0Z1M3C2V/Screen%20Recording%202017-08-05%20at%2004.02%20PM.gif?X-CloudApp-Visitor-Id=2808700&v=08cd0efb)

----------

## Description
Easily create reusable components in Framer, without the hassle of actually writing a class.

**Check out some demos:**

[iOS Control Center](https://framer.cloud/kHTCh/) | [Buttons](https://framer.cloud/qjNTq/) | [Weird, chaotic demo](https://framer.cloud/OEfot/) | [Intro Animation](https://framer.cloud/ZNUgv/)

## Installation

**Step 1** Download and copy `Symbol.coffee` in your project's `/modules`-folder.

**Step 2** Require the `Symbol`-module in your project

`{Symbol} = require 'Symbol'`

## Usage

### Create a new Symbol

`SymbolName = new Symbol(template, states)`

As you can see, the Symbol-class takes two parameters:

Parameter | Type | Description
-------- | ---- | -------
`template` | layer | `required` This is the layer, that will be used as template
`states` | array | `optional` An array of states, that will be applied to every instance [Read More](#symbol-states)

##### Example
Let's create a `Button`-Symbol as an example:

``` coffeescript
#Require the module
{Symbol} = require 'Symbol'

# Initialize your symbol
Button = new Symbol(button_default)

# Create buttonInstance
buttonInstance = new Button
	x: Align.center
	y: Align.center
	...
```

... now you have your `Button`-symbol ready to use and you can go back in **Design-Mode**, edit away and the changes will reflect in all of your instances in Code!

## Symbol States
![framerdemo](https://dr5mo5s7lqrtc.cloudfront.net/items/440L270G0E3I0a2n263W/Bildschirmfoto%202017-08-02%20um%2021.43.45.png?X-CloudApp-Visitor-Id=2808700&v=91c69262)

But wait... there's more! The module also gives you the power to create different states for your symbol in **Design-Mode** and apply those in Code.

You can either apply **common** or **specific** states.

### Common States
Common states apply to **ALL** symbol-instances.

They get applied on initialization of the Symbol as an `Array`:

Property | Type | Description
-------- | ---- | -------
`name` | string | The name of the state
`template` | layer | The template that should be used as state

##### Example

```coffeescript
#Require the module
{Symbol} = require 'Symbol'

# Create common states
commonStates = [
	{
		name: "disabled"
		template: button_disabled
	},
	{
		name: "active"
		template: button_active
	}
]

# Initialize your symbol
Button = new Symbol(button_default, commonStates)

# Create buttonInstanceOne
buttonInstanceOne = new Button
	x: Align.center
	y: 100
	...

# Create buttonInstanceTwo
buttonInstanceTwo = new Button
	x: Align.center
	y: 200
	...
```

... now both `buttonInstanceOne` and `buttonInstanceTwo` have the 3 states `default, disabled` and `active`.

### Specific States
Specific states apply to a... specific instance :scream_cat:

Specific states are being applied with `layer.addSymbolState(name, template)`

##### Example
```coffeescript
#Require the module
{Symbol} = require 'Symbol'

# Initialize your symbol
Button = new Symbol(button_default, commonStates)

# Create buttonInstanceOne
buttonInstanceOne = new Button
	x: Align.center
	y: 100
	...

# Create buttonInstanceTwo
buttonInstanceTwo = new Button
	x: Align.center
	y: 200
	...

buttonInstanceTwo.addSymbolState('specific', button_specific)
```

... now `buttonInstanceOne` has the state `default` and `buttonInstanceTwo` has the 2 states `default` and `special`.

[Try the buttons protoype](https://framer.cloud/qjNTq/)

----------
## Disclaimer
This module is still very experimental and will probably sooner than later be unnecessary, because the beautiful people at Framer will make a proper implementation for something like this.

Meanwhile I'm going to keep hacking on this and would love your contribution! <3

## Credits
The code is based on the earlier exploration of [Andreas Wahlström's createClass-module](https://github.com/awt2542/createClass-for-Framer) - so thanks for that! :tada:

----------
#### TODO

- [x] Add textLayer animations
- [x] Add SVGLayer support
- [x] Fix layer-nesting
- [x] Common / Reusable Symbol states
- [ ] Improve README
- [ ] Discover support for reuse in other projects
- [ ] Discover nested symbols

----------
##### * Pssst! It actually is a class...
..."Symbol" is just a synonym taken from Sketch...
