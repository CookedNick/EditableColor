//
//  SystemExtensions.swift
//  
//
//  Created by Nicolas Cook Leon on 2/18/20.
//

import SwiftUI

#if os(iOS)
@available(iOS 13.0, *)
public extension UIColor {
	
	/// Initializes a `UIColor` using the data currently stored in an `EditableColor` instance. To display a changing color while it's being edited, create a new `UIColor` every time the values are modified. `EditableColor` conforms to `ObservableObject`, so there are appropriate `Combine` methods available to be notified from changes.
	convenience init(_ color: EditableColor) {
		switch color.colorspace {
		case .sRGB:
			self.init(red: CGFloat(color.red),
					  green: CGFloat(color.green),
					  blue: CGFloat(color.blue),
					  alpha: CGFloat(color.alpha))
		case .P3:
			self.init(displayP3Red: CGFloat(color.red),
					  green: CGFloat(color.green),
					  blue: CGFloat(color.blue),
					  alpha: CGFloat(color.alpha))
		}
	}
}
#elseif os(OSX)
@available(OSX 10.15, *)
public extension NSColor {
	
	/// Initializes an `NSColor` using the data currently stored in an `EditableColor` instance. To display a changing color while it's being edited, create a new `UIColor` every time the values are modified. `EditableColor` conforms to `ObservableObject`, so there are appropriate `Combine` methods available to be notified from changes.
	convenience init(_ color: EditableColor) {
		switch color.colorspace {
		case .sRGB:
			self.init(red: CGFloat(color.red),
					  green: CGFloat(color.green),
					  blue: CGFloat(color.blue),
					  alpha: CGFloat(color.alpha))
		case .P3:
			self.init(displayP3Red: CGFloat(color.red),
					  green: CGFloat(color.green),
					  blue: CGFloat(color.blue),
					  alpha: CGFloat(color.alpha))
		}
	}
}
#endif

@available(iOS 13.0, OSX 10.15, *)
public extension SwiftUI.Color {
	
	/// Initializes a color using the data currently stored in an `EditableColor` instance. To display a changing color while it's being edited, store the `EditableColor` instance inside of an `@ObservedObject` property wrapper within the view that calls this initializer or one of its parents.
	init(_ color: EditableColor) {
		
		#if os(iOS)
		self.init(UIColor(color))
		#elseif os(OSX)
		self.init(NSColor(color))
		#else
		fatalError()
		#endif
		
		// You'd think that you'd use the relevant Color initializers here for the proper colorspace, but the values are distorted when viewed in P3 for some reason. UIColor doesn't have this issue, so we can nail it by just falling back to UIKit in this case.
	}
}
