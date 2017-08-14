# framer-Symbols
A module to create symbols in Framer

![framerdemo](https://dr5mo5s7lqrtc.cloudfront.net/items/3z2z2A3P353E0Z1M3C2V/Screen%20Recording%202017-08-05%20at%2004.02%20PM.gif?X-CloudApp-Visitor-Id=2808700&v=08cd0efb)

----------

#### Introduction

This module is based on the earlier exploration of [Andreas Wahlström's createClass-module](https://github.com/awt2542/createClass-for-Framer)

The idea is to easily create reusable components in Framer, without the hassle of actually writing a class.

[Weird, chaotic demo](https://framer.cloud/OEfot/)

#### Getting started

**Step 1** Download and copy `Symbol.coffee` in your project's `/modules`-folder.

**Step 2** Require the `Symbol`-module and convert anything you want to reuse into a Symbol

```coffeescript
{createSymbol} = require 'Symbol'

Card = createSymbol(cardTemplate)

```

**Step 3** Now you created a new LayerType, you can reuse in your project.

```coffeescript
card = new Card
	parent: scroll.content
	...
```

... now you have your `Card`-symbol ready to use and you can go back in **Design-Mode** and edit away and the changes will reflect in all of your instances in Code!

[Try the cards protoype](https://framer.cloud/Fpjee/)

#### Creating States
But wait... there's more! The module also gives you the power to create different states for your symbol in **Design-Mode** and apply those in Code.

**Here's an example for a button:**

**Step 1** Create different button-states in Design-mode

![framerdemo](https://dr5mo5s7lqrtc.cloudfront.net/items/440L270G0E3I0a2n263W/Bildschirmfoto%202017-08-02%20um%2021.43.45.png?X-CloudApp-Visitor-Id=2808700&v=91c69262)

**Step 2** Create symbol and apply the other state-designs as states via the `addSymbolState`-function:

```coffeescript
Button = createSymbol(button)

btn = new Button
	...

btn.addSymbolState('disabled', button_disabled)
btn.addSymbolState('active', button_active)
```

... now your `btn`-symbol has 3 states: `default`, `disabled` and `active`!

[Try the buttons protoype](https://framer.cloud/qjNTq/)

----------
#### Disclaimer
This module is still very experimental and will probably sooner than later be unnecessary, because the beautiful people at Framer will make a proper implementation for something like this.

Meanwhile I'm going to keep hacking on this and would love your contribution! <3

----------
#### TODO

- [x] Add textLayer animations
- [x] Add SVGLayer support
- [ ] Fix layer-nesting
- [ ] Better README
- [ ] Discover support for reuse in other projects
- [ ] Discover nested symbols
