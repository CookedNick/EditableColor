//
//  EditableColor.swift
//
//
//  Created by Nicolas Cook Leon on 2/18/20.
//

@available(iOS 13.0, OSX 10.15, *)
public struct EditableColor: Equatable, Hashable {
	
	/// Initialize an `EditableColor` value. Default arguments are derived from `EditableColor.defaultValues`, which can be modified by users of this package.
	public init(red: Component? = nil, green: Component? = nil, blue: Component? = nil, alpha: Component? = nil, colorspace: Colorspace? = nil) {
		id = UUID()
		self.red = red ?? EditableColor.defaultValues.red
		self.green = green ?? EditableColor.defaultValues.green
		self.blue = blue ?? EditableColor.defaultValues.blue
		self.alpha = alpha ?? EditableColor.defaultValues.alpha
		self.colorspace = colorspace ?? EditableColor.defaultValues.colorspace
		super.init()
	}
	
	
	/// A color's red value. Between 0 and 1.
	public var red: Component
	
	/// A color's green value. Between 0 and 1.
	public var green: Component
	
	/// A color's blue value. Between 0 and 1.
	public var blue: Component
	
	/// A color's alpha value. Between 0 and 1.
	public var alpha: Component
	
	/// A color's colorspace value. Default (for best compatibility) is sRGB. Submit a pull request or issue [on GitHub](https://github.com/DonSwet/EditableColor) if you need more options.
	public var colorspace: Colorspace
	
	
	/// The `#RRGGBB`-esque string representation.
	public var hexValue: String {
		"#\(String(format: "%02X%02X%02X", Int(red * 0xff), Int(green * 0xff), Int(blue * 0xff)))"
	}
	
	/// The `#RRGGBBAA`-esque string representation, including two extra characters representing the alpha value.
	public var hexValueWithAlpha: String {
		"#\(String(format: "%02X%02X%02X%02X", Int(red * 0xff), Int(green * 0xff), Int(blue * 0xff), Int(alpha * 0xff)))"
	}
	
	
	/// Default values for `Color`'s initializer. You can edit this.
	public static var defaultValues = EditableColor()
	
	
	public enum Colorspace: String {
		case sRGB = "sRGB", P3 = "P3"
	}
	
	public typealias Component = Double
}
