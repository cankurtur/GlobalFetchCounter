# GlobalFetchCounter

`GlobalFetchCounter` is an iOS application developed using SwiftUI. It provides users with response code information by fetching data from a server.

## Features

- Fetch the response code from the server.
-	Keep the fetch count in the app until it is deleted.

## Tech Stack

- Combine: Used for reactive programming and handling API requests.
-	MVVM (Model-View-ViewModel): Adopted as the architectural pattern.
-	Modularized structure: Achieved using local Swift packages.

## App Structure

The app is structured with modularization and testable. UI components and network layer are differen module. 

### Architecture Overview:

- View Layer: Built using ComponentKit, this layer handles the user interface and interactions.
- ViewModel Layer: Manages the business logic and data operations.

### Data Flow:

- The View displays a fetch button to the user
- When the user taps the button, the View triggers an action in the ViewModel

### Network Communication:

- The ViewModel contains a service provider
- The service provider manages Global networking configuration and endpoints
- When triggered, it creates and returns a network request publisher

### State Management:

- The ViewModel subscribes to the network request publisher
- It listens for incoming data values from the network
- Upon receiving data, it updates the fetch state

### UI Updates:

- The View maintains a dependency on the Fetch state
- When the state changes, the View automatically refreshes to reflect the new data

## Frameworks
### GlobalNetworking

`GlobalNetworking` is a custom framework used in the GlobalFetchCounter project for making API requests.

### ComponentKit

This module contains the most common components used across the app, such as `AppButton`, `AppDescriptedText`, etc.

- `AppButton`: A custom button view that accepts a label and an action.
-	`AppDescriptedText`: A view that displays a title and description with custom styling.
-	`AppGradientButton`: A custom gradient button with an optional loading state.
-	`AppLinearGradient`: A custom linear gradient used as both a ShapeStyle and a View.
-	`AppColor`: A struct that defines the common colors used throughout the app.
-	`AppFont`: A struct that defines the common fonts used throughout the app.
-	`AppPadding`: A struct that defines the common paddings used throughout the app.

## Diagram

![image](https://github.com/user-attachments/assets/2fd3242a-3709-444b-9be2-18478a9c1c2d)

The App retains a FetchCounterModule which consists of a View and ViewModel. The View components are imported from ComponentKit. When the fetch button is tapped, the View communicates with the ViewModel. The ViewModel retains a service provider, which in turn retains Global networking and related endpoint items. The service provider returns a network request publisher to the ViewModel. The ViewModel subscribes to this publisher and listens for values. Once values are emitted, the ViewModel updates the fetch state. Since the View depends on this state, it automatically updates itself accordingly.

## Technial Decisions

- Using `ServiceProvider` increases testability. During testing, ServiceProvider can be mocked, allowing for the modification of network request responses.
-	In `NetworkManagerProtocol`, the associatedtype is used to restrict endpoint items for the network manager. This approach ensures that each module has only the relevant endpoint items.
-	In `CodeFetcherServiceProvider`, the request methods are written one by one. Since the app only has two requests, generic values are not used. Additionally, by writing all methods explicitly, Xcode resolves them at build time, avoiding runtime resolution of generic values.
-	In alignment with SOLID principles, `CodeFetcherServiceProvider` is injected into the `CounterViewModel`. This allows for easier mocking of the service provider during testing.
-	A custom `@propertyWrapper` named `UserDefaultsProperty` was created to facilitate storing and retrieving values in `UserDefaults`. This wrapper supports the storage of `Codable` responses in `UserDefaults`.
-	To safeguard sensitive information such as API keys and base URLs, a `Config` file was created. This approach centralizes the management of sensitive values and ensures they are securely handled within the application, preventing direct access to these values

## CI-CD 

Bitrise has been integrated into the project to ensure code quality and stability. For every pull request to the main and develop branchs, all tests are automatically executed. The merge option becomes available only after all tests successfully pass, preventing unstable or faulty code from being merged.

Below is the app dashboard on Bitrise:
https://app.bitrise.io/app/c6de89f9-766e-4cb9-b221-2e40044f941e

## Trade-offs
### Not using Singleton for NetworkManager
The network manager could be used with a `CompositionRoot` singleton class. Since the network manager is thread-safe, it would be possible to create a `CompositionRoot` singleton and add the network manager as a lazy variable. This way, the network manager would be accessible throughout the app via the singleton.

However, instead of using a singleton, I chose to create a network manager instance inside the service provider.

- Disadvantages of this approach:
  - A new instance of the network manager is created whenever a new screen is initialized.
  - These instances are retained in memory, which could lead to slightly higher resource usage.

- Why I avoided using a singleton:
  - Increased testability: Creating the network manager inside the service provider allows for better dependency injection and easier mocking during testing.
  - Scoped instances: Each module can have its own relevant services using associatedtype in the network manager protocol, ensuring a more modular and maintainable code structure.
  - Performance is not a concern: The app supports iOS 16 and later, meaning the target devices are powerful enough to handle multiple instances efficiently.
  - Singletons are hard to test: A singleton instance is globally shared, making it difficult to isolate and mock dependencies during testing.

This approach prioritizes testability and modularity over minor performance optimizations. 

### XCFramework for GlobalNetworking 

- Reusability & Modularity – By packaging `GlobalNetworking` as an `XCFramework`, it can be easily reused across multiple projects without duplicating code.
- Binary Distribution – Since `XCFrameworks` contain precompiled binaries, they improve build times and make integration more efficient.
- Cross-Platform Support – `XCFrameworks` support multiple architectures (iOS, macOS, etc.), making them more flexible than traditional frameworks.
- Public Repository for Open Access – The framework is now available as a public repository.

### Managing Network Requests: State Management vs. Throttling
I chose to use state management instead of the throttle operator in the FetchCounterViewModel to prevent concurrent API requests. The state already handles the loading case, which partly serves as a throttle mechanism. This approach offers several advantages:

- Provides visual feedback to users through loading states.
- Offers better control over UI states.
- Makes the code more readable and maintainable.
- Facilitates easier testing.

## Notes
UserDefaults caches data for fast access and updates changes immediately within the app. However, it writes these changes to persistent storage (disk) and other processes **asynchronously**. If the app closes suddenly right after saving a value, the change might not be written to disk in time. As a result, when the app reopens, the value retrieved from UserDefaults may not be the latest update, showing an older value instead. It means that if you stop the app after changing the value, you might not see the correct value on the next launch.

Source: 
Overview section, second paragraph 
https://developer.apple.com/documentation/foundation/userdefaults#//apple_ref/doc/uid/10000059i
