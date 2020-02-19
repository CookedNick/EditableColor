//
//  EditableColor.swift
//
//
//  Created by Nicolas Cook Leon on 2/18/20.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, *)
public extension EditableColor.Component {
	
	/// Generates a random component value between 0 and 1.
	static func safeRandom() -> EditableColor.Component {
		.random(in: 0...1)
	}
	
	
	/// Generates a `Text` instance that displays and styles a component value appropriately.
	func text(displayMode: EditableColor.ComponentDisplayMode = .percent) -> Text {
		let text: Text = {
			var text = String(Int(self*displayMode.denominator))
			if let suffix = displayMode.suffix {
				text += suffix
			}
			return Text(text)
		}()
		
		if self == 0 || self == 1 {
			return text
				.bold()
		} else {
			return text
		}
	}
}

@available(iOS 13.0, OSX 10.15, *)
public class EditableColor: NSObject, ObservableObject, Identifiable {
	
	static public let grayDefault = EditableColor(red: 0.5, green: 0.5, blue: 0.5)
	
	
	public init(red: Component? = nil, green: Component? = nil, blue: Component? = nil, alpha: Component = 1, colorspace: Colorspace = .sRGB) {
		id = UUID()
		self.red = red ?? .safeRandom()
		self.green = green ?? .safeRandom()
		self.blue = blue ?? .safeRandom()
		self.alpha = alpha
		self.colorspace = colorspace
		super.init()
	}
	
	
	public let id: UUID
	@Published public var red: Component
	@Published public var green: Component
	@Published public var blue: Component
	@Published public var alpha: Component
	@Published public var colorspace: Colorspace
	
	
	public var hexCode: String {
		"#\(String(format: "%02X%02X%02X", Int(red * 0xff), Int(green * 0xff), Int(blue * 0xff)))"
	}
	
	
	public enum Colorspace: String {
		case sRGB = "sRGB", P3 = "P3"
	}
	
	public enum ComponentDisplayMode: Double {
		case percent = 100, eightBit = 255, tenBit = 1023, sixteenBit = 65535
		
		public var denominator: Double { rawValue }
		
		public var suffix: String? {
			switch self {
			case .percent:
				return "%"
			default:
				return nil
			}
		}
	}
	
	public typealias Component = Double
	
	public struct Display: View {
		
		/// Creates a `Display` view that updates itself whenever an `EditableColor` instance is changed. Set `showingBackground` to `true` (default: `false`) to display a black/white design behind the color to accent edits to a color's alpha component.
		public init(_ color: EditableColor, showingBackground showBackground: Bool = false) {
			_editableColor = ObservedObject(wrappedValue: color)
			self.showBackground = showBackground
		}
		
		
		@ObservedObject private var editableColor: EditableColor
		
		private let showBackground: Bool
		
		
		public var body: some View {
			var animatedColor: some View {
				Color(editableColor)
					.animation(.interactiveSpring())
			}
			
			if showBackground {
				return AnyView(
					Color.white
						.overlay(GeometryReader { geometry in
							Color.black
								.clipShape(Path { path in
									path.move(to: .zero)
									path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
									path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
								})
						})
						.overlay(animatedColor))
			} else {
				return AnyView(animatedColor)
			}
		}
	}
}
