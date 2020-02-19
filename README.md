# EditableColor

A mutable color representation that conforms to `ObservableObject` with automatic, dead-simple bridging to **SwiftUI**, **UIKit**, and **AppKit**.

## Installation

**In Xcode:**
File > Swift Packages > Add Package Dependency... (https://github.com/DonSwet/EditableColor.git)

## Usage

### Create an instance of `EditableColor`

	import EditableColor
	
	// Start with component values
	let color = EditableColor(red: 1, green: 0, blue: 0, alpha: 1, colorspace: .sRGB)
	
	// OR start with random values
	let color = EditableColor()

### SwiftUI - Display an `EditableColor`

If you simply need to display an instance of `EditableColor` without any special requirements you may do so using the `EditableColor.Display` view type.

	struct ContentView: some View {
		var body: some View {
			// No need to retain the color using @ObservedObject if we wrap it inside of our custom Display type. Updates will occur automatically.
			EditableColor.Display(color)
		}
	}

### SwiftUI - Using `EditableColor` in place of `Color`

If you need to use an `EditableColor` in the form of SwiftUI's native `Color` type, you may do so. Changes made to the `EditableColor` will not reflect in real-time unless it's stored using an `@ObservedObject` or `EnvironmentObject` property wrapper in the relevant view or one of its parents.

	struct ContentView: some View {
		@ObservedObject var color: EditableColor
	
		var body: some View {
			Text("Hello World!")
				.foregroundColor(Color(color))
		}
	}

### UIKit & AppKit

This is a one-time-use bridge. A `UIColor` or `NSColor` instance generated from an `EditableColor` will **not** automatically display changes made to its original `EditableColor`. You'll have to watch for changes using the `Combine` framework methods on `EditableColor` and manually set the color on each update.

	let uiColor = UIColor(color)
	let nsColor = NSColor(color)

## License

The MIT License (MIT)

Copyright © 2020 Nicolas Cook Leon

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
