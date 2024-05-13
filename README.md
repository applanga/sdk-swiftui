# Applanga SwiftUI SDK for iOS Localization
***
*Version:* 2.0.191

*Website:* <https://www.applanga.com> 

*Changelog:* <https://www.applanga.com/changelog/ios>
***


## Table of Contents

  1. [Installation](#installation)
  2. [Configuration](#configuration)
  3. [Usage](#usage)

Automatic Push Notification Localization and InfoPlist.strings

## Installation
#### CocoaPods [[?](http://cocoapods.org)]

1. Refer to CocoaPod’s [Getting Started Guide](http://cocoapods.org/#getstarted) for detailed instructions about CocoaPods.

2. After you have created your Podfile, insert this line of code: `pod 'ApplangaSwiftUI'`, to be able to do screenshots during UI Tests insert `pod 'ApplangaUITest'` for your UI Test Target.

3. Once you have done so, re-run **pod install** from the command line.

#### Swift Package Manager [[?](https://swift.org/package-manager/)]

##### NOTE: This is only supported in Xcode versions 12+

1: Simply add the repo url https://github.com/applanga/sdk-swiftui as a swift package dependency, and select the latest release tag 

## Configuration

See https://www.applanga.com/docs/integration-documentation/ios#configuration

## Usage
### Basic:

See: https://www.applanga.com/docs/integration-documentation/ios#configuration

### Extended:

1. **Code Localization**
 
	To enable localization globally in your app, add the following line before creating your App object

	```swift
	import ApplangaSwiftUI

	@main
	struct SomeApp: App {
	}
	```

	There is no need to add the import in every View file

	1.1 **Strings** 
	
	SwiftUI components can be created normally, by passing the Applanga dashboard key name as the argument

	```swift
	Text("text_title1")
	TextField("text_field_title1", text: $text, axis: .horizontal)
    Button("button_title1") {}
	```

	The key would be automatically localized by the SDK

	1.2 **LocalizedStringKey**

	All existing LocalizedStringKey usages should be converted to ApplangaLocalizedStringKey to enable localization using the SDK.
	To easily perform it in one place, add the following line before creating your App object

	```swift
	typealias LocalizedStringKey = ApplangaLocalizedStringKey

	@main
	struct SomeApp: App {
	}
	```

	Now no additional code changes are required, and the following examples would also be localized

	```swift
	Text(LocalizedStringKey("text_title1"))
    Toggle(LocalizedStringKey("text_title2"), isOn: $toggle)
	Label(ApplangaLocalizedStringKey("text_title3"))
	```

	1.3 **String Interpolation**

	String interpolation is supported with the SDK, the same way SwifUI generates localization keys.
	The following example shows what keys are taken from the dashbaord when creating the components
	
	1.3a
	The required key is: `text_interpolation%lld`, and the localized value would be formatted with `5`

	```swift
	let number = 5
	Text("text_interpolation\(number)")
	```

	1.3b
	The required key is: `text_interpolation%.2f`, and the localized value would be formatted with `55.00`

	```swift
	let number = 55.0
	TextField("text_interpolation\(number, specifier: "%.2f")", text: $text) 
	```

	1.3c
	The required key is: `text_interpolation_%@_1`, and the localized value would be formatted with `SomeText`

	```swift
	let textValue = "SomeText"
	TextField("text_interpolation_\(textValue)_1", text: $text)
	```

	1.3d
	The required key is: `text_interpolation_%@_%@`, and the localized value would be formatted with `PositionValue1` followed by `PositionValue2`

	```swift
	let positionValue1 = "PositionValue1"
    let positionValue2 = "PositionValue2"
	TextField("text_interpolation_\(positionValue1)_\(positionValue2)_1", text: $text)
	```

	The positional formatting can be provided in the translation itself, for example by setting the localized value to: `Text Interpolation Pos2 %2$@ Pos 1 %1$@`

	1.4 **Attributed Strings**
	
	1.4a
	When creating a SwiftUI component, use the init method for AttributedString that has `localized` as the first argument (all the variations are supported)

	```swift
	Text(AttributedString(localized: "text_attributed1", options: options, including: scope))
	```

	The localized value can include all the natively supported attributes

	1.4b
	When using String.LocalizationValue to create attributed strings, it is needed to convert it to String.ApplangaLocalizationValue
	To easily perform it in one place, add the following line before creating your App object

	```swift
	extension String {
    	typealias LocalizationValue = ApplangaLocalizationValue
	}

	@main
	struct SomeApp: App {
	}
	```

	```swift
	Text(AttributedString(localized: String.LocalizationValue("text_attributed4"), options: options, including: scope))
	```

	1.4c
	Interpolation and format arguments is also supported for attributed strings the same way as previously described for normal strings
	In the example below the required key is: `text_attributed%lld`, and the localized value would be formatted with `1`

	```swift
	let count: Int = 1
	Text(AttributedString(localized: "text_attributed\(count)", options: options, including: scope))
	```
	



		
2. **Update Content**
	
	To trigger an update call:
	
	```swift
	@main
	struct SomeApp: App {
    	var body: some Scene {
        	WindowGroup {
            	ZStack {
				}
				.onAppear {
					Applanga.update { success in
					}
				}
			}
		}
	}
	```


3. **Change Language**
 
  	See https://www.applanga.com/docs/integration-documentation/ios#usage

4. **Screenshot Capturing**
 	
	The best method to take screenshots for your translations with SwiftUI is doing your screenshots within UITests as described in [Automated during UITests](#Automated-during-UITests).

	To enable the collection of string positions on your screen with SwiftUI you need to enable the applanga ID mode, which means that every string will shown by its ID and not by its localization. This is the only method to be 100% accurate on linking the correct ids with their positions to the screenshot.
	To enable the applanga show ID mode pass the parameter to your ApplangaUITest instance:

	```swift
		let app = XCUIApplication()
		let applangaUITest = ApplangaUITest(app: app, enableShowIdMode: true)
		app.launch()
	```

	A good practice is to take all your screenshots with show id mode enabled once and then take all screenshots without the show id mode. Then all screenshots have the correct translations linked to them and you still can see the screenshot with the actual translations.
