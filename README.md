# Stanford iOS Projects

[Assignment PDFs](https://drive.google.com/drive/folders/1-TWZDChwwzkiGzt78QlPZDzN-j82JfR6)

All projects built using Swift 4.1 and Xcode 9, targeting iOS 11.4.

## Concentration Game

### Demo

<p align="center">
	<img src="Demos/concentration.gif">
</p>

### :heavy_plus_sign: Additional Features

- 6 available themes: halloween, christmas, people, animals, countries, and tech
- Time-based bonus scoring, which awards anywhere from 0 points (10+ seconds after last match) to 10 points (<1 after last match)
- True-to-life 3.5:2.5 aspect ratio for cards
- Support for landscape orientation (cards will rotate to fit on screen)

### :bulb: Challenges & Key Takeaways

- Understanding Optionals is a unique and challenging concept. Thankfully, this project didn't rely on them too much.
- Getting accustomed to argument & parameter labels is odd, but not an unwelcome language feature.
- The `Collection` protocol makes working with `Array`, `Dictionary`, and other data structures easier than other object-oriented languages.
- Surprisingly, the `--` and `++` operators were [removed in Swift 3](https://github.com/apple/swift-evolution/blob/master/proposals/0004-remove-pre-post-inc-decrement.md). Weird, but I don't disagree with the thorough justification.
- Markdown documentation comments are great for both readability and knowledge transfer.
- `extension` is a very useful tool for organizing code and isolating scary algorithms.

## Set Game

### :heavy_plus_sign: Additional Features

- Uses a [Swift language version build configuration](https://github.com/apple/swift-evolution/blob/master/proposals/0020-if-swift-version.md) statement to swap the `shuffle()` implementation for the Swift 4.2 implementation, depending on the Swift version

### :bulb: Challenges & Key Takeaways

- I actually wanted to use several features only available in Swift 4.2: [`CaseIterable`](https://github.com/apple/swift-evolution/blob/master/proposals/0194-derived-collection-of-enum-cases.md) and [`Sequence.shuffle()`](https://github.com/apple/swift-evolution/blob/master/proposals/0202-random-unification.md).

