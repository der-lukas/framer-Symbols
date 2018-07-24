# Framer Symbols
Create symbols[*](#-pssst-it-actually-is-a-class) in Framer

![framerdemo](https://cdn.pbrd.co/images/HnRvNeh.gif)

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
![framerdemo](https://cdn.pbrd.co/images/HnRI6Qe.png)

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

## Tutorials
Chris Slowik [(@chrislowik)](https://twitter.com/chrisslowik) created a series of tutorials on designers.how, check them out here:
https://designers.how/episodes/design-based-symbols-in-framer

----------
## Disclaimer
This module is meant to be filling the gap until Framer releases their own implementation of Symbols/Components.
Even though I try to thoroughly test everything before I release new features, there's always a risk of me breaking stuff or API changes.

If you have any problems you run into or feature requests, feel free to open an issue or (even better) create a pull-request! <3

## Credits
The code is based on the earlier exploration of [Andreas Wahlström's createClass-module](https://github.com/awt2542/createClass-for-Framer) - so thanks for that! :tada:

## Google Analytics
Out of curiosity I've integrated Google Analytics into the project to get an idea of how many people are using the module.

If you don't feel comfortable showing up in the stats, simply remove `useGA(true)` inside `Symbol.coffee` file.

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
