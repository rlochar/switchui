# SwitchUI

SwiftUI using Swift enum for state in UI.

This exists to demonstrate a way of changing state within a `View` in a _data-driven_ way. 

The key points in using `enum` combined with `switch` are the following:
- simplified `View` (in this case `ContentView`) 
- no checks i.e `if let` > more readable
- data-driven UI, not _imperative_

The last point is very important and will be further demonstrated in the next section where comparisons are made. While SwiftUI itself is declarative, it is easy to create a system where one has to be cautious about which state the app is in. This creates overhead, confusion and easy mistakes.

## Comparison: Without Enum 
The app could easily have been written in the following way for `ContentView`:
```
VStack {
  if let isSuccess { LoggedInView() }
  if let isFailure { FailedLoginView() }
  if let isLogin { LoginView() }
}
```
However, several issues exists here:
* the app should not **be able** to show more than *one* View *simultaneously*
* added overhead because we have to manually change one or more of `isSuccess`, `isFailure` and `isLogin`

This is compared to the current setup: 
```
switch viewModel.currentState {
  case .fail:
    FailedLoginView(previousScreen: $viewModel.didGoBack)
  case .success:
    LoggedInView(previousScreen: $viewModel.didGoBack)
  case .login:
    LoginView(isLoggedIn: $viewModel.didLogin)
}
```

Where we only need to care about changing *one* setting, to define what the state should be in.

In the `enum` setup there are only 3 states `ContentView` can be in, while without the usage of `enum` it jumps up to 2^3 which is 8! 

## Discussion
The `viewModel` (or whatever one is using) will in this case be a bit more messy due to `didSet` on variables. It is also important (as always) to have good names (which I lack in this example). 

A potential benefit is using *associated values* in the enum cases to send info to a specific View.
```
case success(username: String) // ViewModel enum

case .success(let username): // ContentView
  LoggedInView(username: username)
...
```
That would implicitly mean that when a `didSet { }` occur for `var didLogin` some value was retrieved and passed to the `.success` case.
