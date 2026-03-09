# Assignment

## Overview 
Add deeplinking to the existing WikiPedia iOS App directly open the places tab using coordinates. 

Add SwiftUI demo app to to demo deeplinking behavior. 

## Deeplinking 
Modify Wikipedia App to
- Open directly in the places tab
- Display location specified by coordinates

## Deep link url format
```wikipedia://places?lat=<latitude>&lon=<longitude>```

## DemoApp
A SwiftUI app that fetches locations from a remote URL and displays them in a list.
Tapping a location opens the Wikipedia Places tab at that coordinate via deep link.

### Features
- Fetch and display locations from a remote API
- Open Wikipedia app at a specific coordinate via deep link
- Add custom locations with coordinate validation
- Displays an alert when the Wikipedia app is not installed
- Loading and error states with retry support

### Technical highlights
- Architecture: MVVM with separated Data, Domain, and Presentation layers
- Presenters map localized strings to view data
- Enum-driven state management: loading, error, loaded
- URLSession and UIApplication abstracted behind protocols for testability
- Optimized for accessibility
- Unit test coverage: 77% (views excluded as they contain no business logic)
- Swift Concurrency: async/await for network requests