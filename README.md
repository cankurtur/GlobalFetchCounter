# GlobalFetchCounter

`GlobalFetchCounter` is an iOS application developed using SwiftUI. It provides users with response code information by fetching data from a server.

## Features

- Fetch the response code from the server.
-	Keep the fetch count in the app until it is deleted.

## Tech Stack

- Combine: Used for reactive programming and handling API requests.
-	MVVM (Model-View-ViewModel): Adopted as the architectural pattern.
-	Modularized structure: Achieved using local Swift packages.

## Frameworks
### GlobalNetworking

`GlobalNetworking` is a custom framework used in the GlobalFetchCounter project for making API requests.

## App Structure

The app is structured with modularization. Within the same project, there are different modules.

### FetchCounterModule

This module is responsible for retaining the fetch counter screen. It can make its own API requests independently. All resources are contained within the module, and module tests are written inside it as well.

- `CodeFetcherServiceProvider`: A provider that handles API requests for `FetchCounterView`. It has two different methods using Combine for API requests via `GlobalNetworking`.
- `CodeFetcherEndpointItem`: An endpoint item that conforms to the `Endpoin`t protocol provided by `GlobalNetworking`. It handles the paths and methods for API requests within the module.
- `CounterView`: A view structure containing UI elements. App components are imported here.
- `CounterViewModel`: A view model responsible for business logic. The `CodeFetcherServiceProvider` is injected into this class, and the API response is subscribed to here before being passed to the view.
  
### CommonKit

This module is responsible for managing common functionalities, managers, and configurations throughout the app. To use these common functionalities, you need to import this module.

- `ClientEndpointItem`: This is the default configuration for the Endpoint. It includes default settings such as the base URL, headers, and other configurations. Since the app uses the same base URL, these default values are implemented here.
- `ClientError`: This is a client-side API error class. It can handle and be cast to different client errors received from the server.
- `CompositionRoot`: A singleton class that retains the network manager. It ensures that the same instance of the network manager is used throughout the app, preventing multiple instances from being created by different modules. Additionally, any other classes that need to be retained throughout the app’s lifetime will be added in the `CompositionRoot`. This ensures that these classes have a single instance throughout the app and are accessible wherever needed.
- `Config`: A configuration file that stores basic app settings, such as the base URL.
- `UserDefaultsProperty`: A `propertywrapper` for `UserDefaults` that allows reading and writing values. For test cases, the suite name is changed to ensure that running unit tests does not affect real UserDefaults values.

### ComponentKit

This module contains the most common components used across the app, such as `AppButton`, `AppDescriptedText`, etc.

- `AppButton`: A custom button view that accepts a label and an action.
-	`AppDescriptedText`: A view that displays a title and description with custom styling.
-	`AppGradientButton`: A custom gradient button with an optional loading state.
-	`AppLinearGradient`: A custom linear gradient used as both a ShapeStyle and a View.

## Diagram

![Screenshot 2025-02-10 at 01 01 36](https://github.com/user-attachments/assets/31de9fed-9a48-47ae-ab72-72f08c451ec4)

The app retains all dependencies, both remote and local, and they are all accessible from the main bundle. The `FetchCounterModule` is imported in the main bundle and the app starts with this module. This module has access to `GlobalNetworking` for making API calls, imports `CommonKit` for shared functionalities, and includes `ComponentKit` to access UI components.

`CommonKit` imports `GlobalNetworking` to create default endpoints for all other modules. This allows consistent API configurations to be shared across the app.

## Technial Decisions

-	In the `NetworkManagerProtocol`, the `associatedtype` is not used to limit endpoint items for the network manager. This approach prevents the creation of multiple instances of the network manager.
-	In `CodeFetcherServiceProvider`, the request methods are written one by one. Since the app only has two requests, generic values are not used. Additionally, by writing all methods explicitly, Xcode resolves them at build time, avoiding runtime resolution of generic values.
-	In alignment with SOLID principles, `CodeFetcherServiceProvider` is injected into the `CounterViewModel`. This allows for easier mocking of the service provider during testing.
-	A custom `@propertyWrapper` named `UserDefaultsProperty` was created to facilitate storing and retrieving values in `UserDefaults`. This wrapper supports the storage of `Codable` responses in `UserDefaults`.
-	To safeguard sensitive information such as API keys and base URLs, a `Config` file was created. This approach centralizes the management of sensitive values and ensures they are securely handled within the application, preventing direct access to these values





