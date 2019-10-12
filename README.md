# FlightPath

### Prerequisites
1) Get a GoogleMap API key
2) Make sure to have CocoaPods installed, if not, run "sudo gem install cocoapods"


### Steps to initialize

1) Navigate to the directory /FlightPath on terminal
2) Run "pod install"
3) Open the project
4) Go to ViewController.swift
5) On this variable, type in your API key instead of returning an empty string
// API key for iOS SDK
private let mapAPIKey: String = {
    return ""
}()
6) Connect your device and run the app

### How to use the app?
1) The app will start by showing your current location
2) Long press to add markers to the map
3) If there are two markers or more, pressing the "Draw" button on the top right of the screen will draw a line
   connecting the markers.
