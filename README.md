# Stanford iOS Projects

[Assignment PDFs](https://drive.google.com/drive/folders/1-TWZDChwwzkiGzt78QlPZDzN-j82JfR6)

All projects built using Swift 4.1 and XCode 9, targeting iOS 11.4.

## Concentration Game

<p align="center">
	<img src="Demos/concentration.gif">
</p>

### :heavy_check_mark: Requirements

1. Get the Concentration game working.
2. Add more cards to the game.
3. Add a **New Game** button to your UI which ends the current game in progress and
begins a brand new game.
4. Currently the cards in the Model are not randomized (that’s why matching cards end
up always in the same place in our UI). Shuffle the cards in Concentration’s `init()`
method.
5. Give your game the concept of a “theme”. A theme determines the set of emoji from
which cards are chosen. All emoji in a given theme are related by that theme. See the
Hints for example themes. Your game should have at least 6 different themes and
should choose a random theme each time a new game starts.
6. Your architecture must make it possible to add a new theme in a single line of code.
7. Add a game score label to your UI.
8. Tracking the flip count almost certainly does not belong in your Controller in a proper
MVC architecture. Fix that.
9. All new UI you add should be nicely laid out and look good in portrait mode on an
iPhone X.

#### :heavy_plus_sign: Additional Features

- 6 available themes: halloween, christmas, people, animals, countries, and tech
- Time-based bonus scoring, which awards anywhere from 0 points (10+ seconds after last match) to 10 points (<1 after last match)
- True-to-life 3.5:2.5 aspect ratio for cards
- Support for landscape orientation (cards will rotate to fit on screen)

### :bulb: Challenges & Key Takeaways

- Understanding Optionals is a unique and challenging concept. Thankfully, this project didn't rely on them too much.
- Getting accustomed to argument & parameter labels is odd, but not an unwelcome language feature.
- The `Collection` protocol makes working with `Array`, `Dictionary`, and other data structures easier than other object-oriented languages.
- Surprisingly, the `--` and `++` operators were [removed in Swift 3](https://github.com/apple/swift-evolution/blob/master/proposals/0004-remove-pre-post-inc-decrement.md). Weird, but I don't disagree with the thorough justification.
- Markdown documentation comments are awesome.
- `extension` is awesome!

## Set Game

### :heavy_check_mark: Requirements

1. Implement a game of solo Set.
2. Have room on the screen for at least 24 Set cards. All cards are always face up in Set.
3. Deal 12 cards only to start.
4. You will also need a “Deal 3 More Cards” button (as per the rules of Set).
5. Allow the user to select cards to try to match as a Set by touching on the cards. Also support “deselection” (but when only 1 or 2 (not 3) cards are currently selected).
6. After 3 cards have been selected, you must indicate whether those 3 cards are a match
or a mismatch (per Set rules).
7. When any card is chosen and there are already 3 non-matching Set cards selected,
deselect those 3 non-matching cards and then select the chosen card.
8. As per the rules of Set, when any card is chosen and there are already 3 matching
Set cards selected, replace those 3 matching Set cards with new ones from the deck of
81 Set cards.
9. When the Deal 3 More Cards button is pressed either a) replace the selected cards if
they are a match or b) add 3 cards to the game.
10. The Deal 3 More Cards button should be disabled if there are a) no more cards in the
Set deck or b) no more room in the UI to fit 3 more cards (note that there is always
room for 3 more cards if the 3 currently-selected cards are a match since you replace
them).
11. Instead of drawing the Set cards in the classic form, we’ll use these three characters ▲ ● ■ and use attributes in NSAttributedString to draw them
appropriately (i.e. colors and shading). That way your cards can just be `UIButton`s.
12. Use a method that takes a closure as an argument as a meaningful part of your
solution.
13. Use an `enum` as a meaningful part of your solution.
14. Add a sensible `extension` to some data structure as a meaningful part of your
solution.
15. Your UI should be nicely laid out and look good (at least in portrait mode, preferably
in landscape as well, though not required) on any iPhone 7 or later device.
16. You must have a **New Game** button and show the **Score** in the UI.
