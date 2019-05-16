# HTTPCodable
[![Build Status](https://travis-ci.com/terwanerik/HTTPCodable.svg?branch=master)](https://travis-ci.com/terwanerik/HTTPCodable)
[![swift 4.2](https://img.shields.io/badge/swift-4.0%20%7C%204.2%20%7C%205.0-green.svg)](https://swift.org)
[![osx | ubuntu | docker](https://img.shields.io/badge/platform-iOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20linux-lightgrey.svg)](https://swift.org/download/#releases)

HTTPCodable allows you to send HTTP requests (with Codable's as body) and get a Codable, wrapped in a Future, back. A picture is worth a thousand words:
```swift
struct Todo: Codable {
  var id: Int
  var userId: Int
  var title: String
  var completed: Bool
}

let url = "https://jsonplaceholder.typicode.com/todos"

Client.shared.get(url, as: [Todo].self).map { todos in
  // todos is an array of Todo objects
  return todos.filter { $0.completed }
}.whenFulfilled { completed in
  // completed is an array of completed todos
}
```

It heavily relies on [Futures](https://github.com/formbound/Futures) and will return a Future for all requests.

## Examples
Have a look at `HTTPCodableTests` for more examples, the code itself is also pretty explanatory.

```swift
import HTTPCodable

/// Our object
struct Todo: Codable {
  var id: Int
  var userId: Int
  var title: String
  var completed: Bool
}

/// You can define your ?query=string&s=foo as Codable structs
struct TodoQuery: Codable {
  var id: Int?
  var userId: Int?
  var completed: Bool?
}

Client.shared.baseUrl = "https://jsonplaceholder.typicode.com/"

// Simple GET
Client.shared.get("/todos", as: [Todo].self).whenFulfilled { todos in
  // todos is an array of Todo objects
}

// GET with query
Client.shared.get("/todos", as: [Todo].self, query: TodoQuery(id: nil, userId: 1, completed: false)).whenFulfilled { todos in
  // todos is an array of Todo objects, with userId=1 and completed=false
}

// Post
let data = Todo(id: 1, userId: 1, title: "Foo", completed: true)
Client.shared.post(data, to: "/todos", as: Todo.self).whenFulfilled { todo in
  // todo is our newly created todo
}

// Put
Client.shared.put(data, to: "/todos/1", as: Todo.self).whenFulfilled { todo in
  // todo is our updated todo
}

// Patch
Client.shared.patch(data, to: "/todos/1", as: Todo.self).whenFulfilled { todo in
  // todo is our patched todo
}

// Delete
struct EmptyResponse: Codable {}

Client.shared.delete("/todos/1", as: EmptyResponse.self).whenFulfilled { _ in
  // removed
}
```

## Getting started

HTTPCodable can be added to your project either using Swift package manager or manually (for now);

### SPM
Add HTTPCodable as a dependency
```swift
dependencies: [
    .package(url: "https://github.com/terwanerik/HTTPCodable.git", from: "0.1.0")
]
```

Then import the module
```swift
import HTTPCodable
```

### Manually
Download one of the releases, and just drag the `/Sources/HTTPCodable` folder in Xcode. Make sure to install [Futures](https://github.com/formbound/Futures) as a framework (e.g. via Carthage)

### Supported Platforms

HTTPCodable supports all platforms where [Futures](https://github.com/formbound/Futures) is supported; so all platforms where Swift 3 and later is supported.

* Ubuntu 14.04
* macOS 10.9
* tvOS 9.0
* iOS 8.0
* watchOS 2.0
