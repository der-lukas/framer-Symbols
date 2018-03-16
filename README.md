# framer-Symbols
A module to create symbols[*](#-pssst-it-actually-is-a-class) in Framer

![framerdemo](https://dr5mo5s7lqrtc.cloudfront.net/items/3z2z2A3P353E0Z1M3C2V/Screen%20Recording%202017-08-05%20at%2004.02%20PM.gif?X-CloudApp-Visitor-Id=2808700&v=08cd0efb)

----------

## Description
Easily create reusable components in Framer, without the hassle of actually writing a class.

**Check out some demos:**

[Form Element Symbols](https://framer.cloud/MjZgp) |
[iOS Control Center](https://framer.cloud/Xlgod/) | [Intro Animation](https://framer.cloud/ZNUgv/) | [Common Event Buttons](https://framer.cloud/IpDbI)

*:exclamation: To always load the latest version of the module, these demos use [Marc Krenn's "testDrive"-snippet](https://github.com/marckrenn/framer-testDrive). This causes some flickering and warnings for some seconds, when opening the demos. :exclamation:*

## Installation

### Automatic Installation with [Framer Modules](https://www.framermodules.com/)

<a href='https://open.framermodules.com/Symbols'>
    <img alt='Install with Framer Modules'
    src='https://www.framermodules.com/assets/badge@2x.png' width='160' height='40' />
</a>

### Manual Installation

**Step 1** Download and copy `Symbol.coffee` in your project's `/modules`-folder.

**Step 2** Require the `Symbol`-module in your project

`{Symbol} = require 'Symbol'`

## Usage

### Create a new Symbol

`SymbolName = Symbol(template, states, events)`

The Symbol-class has the following parameters:

Parameter | Type | Description
-------- | ---- | -------
`template` | layer | `required` This is the layer, that will be used as default-template
`states` | Object | `optional` A states-object, that will be applied to every instance [Read More](#symbol-states)
`events` | Object | `optional` An events-object, that will be applied to every instance [Read More](#symbol-events)

##### Example
Let's create a `Button`-Symbol in its simplest form as an example:

``` coffeescript
#Require the module
{Symbol} = require 'Symbol'

# Initialize your symbol
Button = Symbol(button_default)

# Create buttonInstance
buttonInstance = new Button
  x: Align.center
  y: Align.center
  ...
```

... now you have your `Button`-symbol ready to use and you can go back in **Design-Mode**, edit away and the changes will reflect in all of your instances in Code!

## Symbol States
![framerdemo](https://dr5mo5s7lqrtc.cloudfront.net/items/440L270G0E3I0a2n263W/Bildschirmfoto%202017-08-02%20um%2021.43.45.png?X-CloudApp-Visitor-Id=2808700&v=91c69262)

The module also gives you the ability to create different states for your symbol in **Design-Mode** and apply those in Code.

You can either apply **common** or **specific** states.

### Common States
Common states apply to **ALL** symbol-instances.
They are being applied on initialization of the Symbol.

For each state you can define following properties:

Property | Type | Description
-------- | ---- | -------
`template` | layer | `optional` The template that should be used as state
`properties` | Object | `optional` You can supply props that should change for this state
`animationOptions` | Object | `optional` The applied animation options [Framer Docs](https://framer.com/docs/#layer.states)

##### Example

```coffeescript
#Require the module
{Symbol} = require 'Symbol'

# Create common states
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
Button = Symbol(button_default, commonStates)

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


The `animationOptions` don't need to be supplied for each commonState, but can also be set as default for all states like this:

```coffeescript
...
# Create common states
commonStates =
  animationOptions:
    curve: Spring(damping: 1)
    time: 0.7
  disabled:
    template: button_disabled
  active:
    template: button_active
...
```

### Specific States
Specific states apply to a specific instance :scream_cat:

Specific states are being applied with `layer.addSymbolState(name, template, animationOptions = false)`

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

... now `buttonInstanceOne` has the state `default` and `buttonInstanceTwo` has the 2 states `default` and `specific`.

[Buttons Prototype](https://framer.cloud/qjNTq/)

## Symbol Events
You can apply common events to **ALL** symbol-instances.
They are being applied on initialization of the Symbol.

Define the commonStates-object like so:

```coffeescript
commonEventsObject =
  eventName: -> yourEvent
```

You can also supply events to descendant-layers of your symbol, like so:

```coffeescript
commonEventsObject =
  eventName: -> yourEvent
  descendantName:
    eventName: -> yourEvent
```

##### Example
```coffeescript
...

# Create common events
commonEvents =
  MouseOver: -> @.animate "hover"
  MouseOut: -> @.animate "default"
  TapStart: -> @.animate "active"
  TapEnd: -> @.animate "hover"
  descendantName:
    Tap: -> print "Foo"

# Initialize your symbol
Button = Symbol(button_default, commonStates, commonEvents)

...
```

Check out [this demo](https://framer.cloud/IpDbI) or visit the [Framer Docs for Events](https://framer.com/docs/#events.events)

## Working with text
As usual in Framer, text that is different between instances or changes its content between states, should be declared as `template`.

Text that stays the same for all instances and states, should be a normal `text`.

[Framer Docs for textLayer](https://framer.com/docs/#text.textlayer)

## Under the hood

_For your better understanding and if something shouldn't work as expected, I want to give you a little insight into what the module does._

### tl;dr
The module basically animates between the `default` states of different layers.

### ...a little more detailed
The module creates a new layerType that extends `Layer`.
This layer basically makes a copy of all the layers of the supplied symbol-template.

When you supply templates-layer for a new `symbolState`, the module applies the the target-layers default-state properties as properties for the new state you are creating.
This happens recursive for all descendants of your symbol, so that every child-layer of a symbol has the same states as the parent.

On `StateSwitchStart`-event of the symbol, the module applies the stateSwitch to all descendants recursively, so that all states stay in sync.

[![Github All Releases](https://img.shields.io/github/downloads/der-lukas/framer-Symbols/total.svg)]()

## Tutorials
Chris Slowik [(@chrislowik)](https://twitter.com/chrisslowik) created a series of tutorials on designers.how, check them out here:
https://designers.how/episodes/design-based-symbols-in-framer

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
- [x] Common Symbol states
- [x] Common Symbol events
- [x] Improve README
- [ ] Discover support for reuse in other projects
- [ ] Discover nested symbols

----------
##### * Pssst! It actually is a class...
..."Symbol" is just a synonym taken from Sketch...
