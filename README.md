# mHaml
## Reusable Modular Template for Rapid Mobile Webapp Development
### What Is It?
mHaml extends capabilities of [Haml](http://haml.info/), which is the most beautiful and succinct way to generate clean, semantic markup.  With mHaml, new templates can be created by defining relationships between existing templates.  mHaml makes mobile webapp development [Haml](http://haml.info/)-ish.

mHaml is built on three core principles:

1. __Reusable__
mHaml is a template writing template. mHaml lets you define templates based on existing templates. In other templates (Haml / ERB), reuse is limited to merely inserting snippets or partials. mHaml is true code reuse.

2. __Mobile Optimized__
[jQuery Mobile](http://jquerymobile.com/) simplifies webapp developmet into one unified codebase. But also comes with wordy syntax that wipes away any advantage of using [Haml](http://haml.info/). mHaml's convenience methods make [jQuery Mobile](http://jquerymobile.com/) webapp development [Haml](http://haml.info/)-like again: clean and succinct.

3. __Lightweight__
mHaml is non-obstrusive and minimal. mHaml is best used with [Sinatra](http://www.sinatrarb.com/intro) (or even stand-alone). mHaml is code generating code.


### Why?
Don't you wish concise outline was all it took to represent a web page? [Haml](http://haml.info/) does just that. In fact, content should remain this way: concise and semantic. Regardless of representation, across different styles, across browsers, and even across mobile devices. And [jQuery Mobile](http://jquerymobile.com/) does just that: insulate against differences in mobile devices. With agaile framework [Sinatra](http://www.sinatrarb.com/intro) and free deployment service [Heroku](http://www.heroku.com/), it may just be possible to create a webapp targeting multiple mobile devices with just a simple outline! Or you thought...

JHS ([jQuery Mobile](http://jquerymobile.com) / [Haml](http://haml.info/) / [Sinatra](http://www.sinatrarb.com/intro) ) combination unfortunately does not play well together.
Majority of [jQuery Mobile](http://jquerymobile.com) tags are regular HTML5 tags with special attributes with 'data-' prefix. Which results in [Haml](http://haml.info/)  code that is longer than the original HTML, and more representation dependent than the semantic HTML equivalent. But, it gets worse. [jQuery Mobile](http://jquerymobile.com) pages are not page based, but div / section based. This makes layout and code reuse a true challenge in [Haml](http://haml.info/).  But the use of multiple partial was never a good idea to begin with.

For the same [reason multiple inheritance (the entire inheritance business, for that matter) was eschewed for the sake of composition](http://en.wikipedia.org/wiki/Composition_over_inheritance), mHaml deliberately forsakes partials. mHaml, instead, lets you define templates based on templates, like [hygienic macro](http://en.wikipedia.org/wiki/Hygienic_macro) of Scheme language. As a result, you can dynamically plug in templates into templates, much like [dependency injection](http://en.wikipedia.org/wiki/Dependency_injection) of Spring framework. And, lexical binding, of course.

### More info
Check out [mHaml.com](http://www.mhaml.com) for more info.
