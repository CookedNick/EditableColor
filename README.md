# EditableColor

A mutable color representation that conforms to `ObservableObject` with automatic, dead-simple bridging to **SwiftUI**, **UIKit**, and **AppKit**.

This package contains all the model code necessary to roll your own color picker.

**Minimum SDK for EditableColor**: *None*

**Minimum SDK for UIKit & AppKit Bridging**: *iOS 10 & macOS 10.12 Sierra*

**Minimum SDK for SwiftUI Bridging**: *iOS 13 & macOS 10.15 Catalina*

## Installation

**In Xcode:**
File > Swift Packages > Add Package Dependency... (https://github.com/DonSwet/EditableColor.git)

## Usage

### Create an instance of `EditableColor`

	import EditableColor
	
	// Start with component values.
	let color = EditableColor(red: 1, green: 1, blue: 1, alpha: 1, colorspace: .sRGB)
	
	// OR start with no values. Default: (red: 1, green: 1, blue: 1, alpha: 1, colorspace: .sRGB)
	let color = EditableColor()
	
	// To change the default initializer arguments, you can edit this static proxy value.
	EditableColor.defaultValues.red = 0

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

This is a one-time-use bridge. A `UIColor` or `NSColor` instance generated from an `EditableColor` will **not** automatically display changes made to its original `EditableColor`. You'll have to replace it manually upon any changes.

	let swiftuiColor = Color(color)
	let uiColor = UIColor(color)
	let nsColor = NSColor(color)

## License

The MIT License (MIT)

Copyright © 2020 Nicolas Cook Leon

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
