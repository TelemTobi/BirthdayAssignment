# Nanit Assignment

## Project Overview

This README provides insights into the architectural decisions, UI implementation, and navigation patterns used in this iOS project.

## Architecture
In a larger scale app, my preference leans towards [The Composable Architecture](https://www.pointfree.co/collections/composable-architecture). This framework enforces a unidirectional flow pattern, offering high testability and seamless integration with SwiftUI.

For this project, I opted for the MVVM architecture. Each view model conforms to the ViewModel protocol, mandating the presence of State and Action associated types. This ensures a consistent data flow throughout the app. 

The ViewModel protocol also provides handy methods, like binding for example, which derives bindings from the viewModel. This approach prevents direct writes to the state and encourages sending actions to the viewModel instead.

Here's a visual representation of the data flow: [Insert data flow image]

## UI
The user interface is built using a combination of SwiftUI and UIKit. This hybrid approach was chosen to tackle the complex UI of the birthday screen, leveraging UIKit's constraint-based system. 

UIHostingControllers were used to embed SwiftUI views within a UIKit navigation system. Additionally, UIViewRepresentable was used for embedding UIViews within SwiftUI views.

To handle theme changes on the Birthday screen, I used an enum with cases for each theme color. This design choice allows for easy management of themes and their related resources in a centralized location.

## Navigation
Navigation follows the classic Coordinator pattern. 

Each module has access to the coordinator through a Router protocol embedded in the viewModel. This enables seamless navigation actions throughout the application.
