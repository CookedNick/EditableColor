//
//  API Bridging.swift
//  
//
//  Created by Nicolas Cook Leon on 2/18/20.
//

import SwiftUI

#if os(iOS)
@available(iOS 10.0, *)
public extension UIColor {
	
	/// Initializes a `UIColor` with values from an `EditableColor`.
	convenience init(_ color: EditableColor, ignoreAlpha: Bool = false) {
		switch color.colorspace {
		case .sRGB:
			self.init(red: CGFloat(color.red),
					  green: CGFloat(color.green),
					  blue: CGFloat(color.blue),
					  alpha: ignoreAlpha ? 1 : CGFloat(color.alpha))
		case .P3:
			self.init(displayP3Red: CGFloat(color.red),
					  green: CGFloat(color.green),
					  blue: CGFloat(color.blue),
					  alpha: ignoreAlpha ? 1 : CGFloat(color.alpha))
		}
	}
}
#elseif os(OSX)
@available(OSX 10.12, *)
public extension NSColor {
	
	/// Initializes an `NSColor` with values from an `EditableColor`.
	convenience init(_ color: EditableColor, ignoreAlpha: Bool = false) {
		switch color.colorspace {
		case .sRGB:
			self.init(red: CGFloat(color.red),
					  green: CGFloat(color.green),
					  blue: CGFloat(color.blue),
					  alpha: ignoreAlpha ? 1 : CGFloat(color.alpha))
		case .P3:
			self.init(displayP3Red: CGFloat(color.red),
					  green: CGFloat(color.green),
					  blue: CGFloat(color.blue),
					  alpha: ignoreAlpha ? 1 : CGFloat(color.alpha))
		}
	}
}
#endif

@available(iOS 13.0, OSX 10.15, *)
public extension SwiftUI.Color {
	
	/// Initializes a `Color` with values from an `EditableColor`.
	init(_ color: EditableColor, ignoreAlpha: Bool = false) {
		
		// Weirdly, Color.init(red, green, blue, alpha, colorspace) isn't behaving as expected. We have to route it through a UIColor or NSColor to display the color accurately.
		
		#if os(iOS)
		self.init(UIColor(color, ignoreAlpha: ignoreAlpha))
		#elseif os(OSX)
		self.init(NSColor(color, ignoreAlpha: ignoreAlpha))
		#else
		fatalError()
		#endif
	}
}
