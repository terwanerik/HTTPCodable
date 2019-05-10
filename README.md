# HTTPCodable
[![Build Status](https://travis-ci.com/terwanerik/HTTPCodable.svg?branch=master)](https://travis-ci.com/terwanerik/HTTPCodable)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

HTTPCodable allows you to send HTTP requests (with Codable's as body) and get a Codable, wrapped in a Future, back. A picture is worth more than a thousand words:
```swift
let url = "https://jsonplaceholder.typicode.com/todos"

Client.shared.get(url, as: [Todo].self).map { todos in
  // todos is an array of Todo objects
}
```

It heavily relies on [Futures](https://github.com/formbound/Futures) and will return a Future for all requests.

## Examples
For now; checkout the `HTTPCodableTests` for examples on how to use.

## Getting started

HTTPCodable can be added to your project either using [Carthage](https://github.com/Carthage/Carthage) or Swift package manager.


If you want to depend on HTTPCodable in your project, it's as simple as adding a `dependencies` clause to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/terwanerik/HTTPCodable.git", from: "0.1.0")
]
```

Or, add a dependency in your `Cartfile`:

```
github "terwanerik/HTTPCodable"
```

More details on using Carthage can be found [here](https://github.com/Carthage/Carthage#quick-start).

Lastly, import the module in your Swift files

```swift
import HTTPCodable
```


### Supported Platforms

HTTPCodable supports all platforms where [Futures](https://github.com/formbound/Futures) is supported; so all platforms where Swift 3 and later is supported.

* Ubuntu 14.04
* macOS 10.9
* tvOS 9.0
* iOS 8.0
* watchOS 2.0
