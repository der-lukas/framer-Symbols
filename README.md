
# framer-Symbols
A module to create symbols in Framer

----------

#### Introduction

This module is based on the earlier exploration of [Andreas Wahlström's createClass-module](https://github.com/awt2542/createClass-for-Framer) 

The idea is to easily create reusable components in Framer, without the hassle of actually writing a class. 

#### Getting started

**Step 1** Download the `symbols-example.framer` project and copy `Symbol.coffee` in your project's `/modules`-folder.

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

#### Creating States
But wait... there's more! The module also gives you the power to create different states for your symbol in **Design-Mode** and apply those in Code.

**Here's an example for a button:**

**Step 1** Create different button-states in Design-mode

**Step 2** Create symbol and apply the other state-designs as states via the `addSymbolState`-function:

```coffeescript
Button = createSymbol(button)

btn = new Button
	...

btn.addSymbolState('disabled', button_disabled)
btn.addSymbolState('active', button_active)
```


----------
#### Heads up!
This module is still very experimental and will probably sooner than later be unnecessary, because the beautiful people at Framer will make a proper implementation for something like this.

Meanwhile I'm going to keep hacking on this and would love your contribution! <3
