# Hot Prospects: Introduction

## Paul Hudson's ([@twostraws](https://x.com/twostraws)) 100 Days of Swift UI Project 16

Source URL: [link](https://www.hackingwithswift.com/books/ios-swiftui/hot-prospects-introduction)

>In this project we’re going to build Hot Prospects, which is an app to track who you meet at conferences. You’ve probably seen apps like it before: it will show a QR code that stores your attendee information, then others can scan that code to add you to their list of possible leads for later follow up.

### Letting users select items in a List

Source URL: [link](https://www.hackingwithswift.com/books/ios-swiftui/letting-users-select-items-in-a-list)

Really interesting technique for letting users select multiple items in a list and present it in a readable way (see animation below):

![Multiple Selection](./images/multiple_selection.gif)

This interesting effect is achieved by adding the `EditButton()` and the `selection.formatted()` in the code below:

```swift
import SwiftUI

struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    @State private var selection = Set<String>()
    
    var body: some View {
        List(users, id:\.self, selection: $selection) { user in
            Text(user)
        }
        
        if !selection.isEmpty {
            Text("You selected: \(selection.formatted())")
        }
        
        EditButton()
    }
}
```

## Acknowledgments

Original code created by: [Paul Hudson - @twostraws](https://x.com/twostraws) (Thank you!)

Made with :heart: by [@cewitte](https://x.com/cewitte)
