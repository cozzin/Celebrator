# Moment
🎉 Celebrate event based on count.

## At a Glance
```swift
import Celebrator

lazy var celebrator = Celebrator()
    .register(AppEvent.event) { [weak self] in
        self?.somthingForEvent()
    }
```

## Installation
### Cocoapods
```
pod 'Celebrator'
```

### Carthage
```
github "cozzin/Celebrator"
```

## Usage

### Make event

```swift
enum AppEvent: String, Event {
    case event1
    case event2

    var id: String {
        return self.rawValue
    }

    var conditionCount: Int {
        switch self {
        case .event1:
            return 1
        case .event2:
            return 2
        }
    }
}
```

### Register event

```swift
lazy var celebrator = Celebrator()
    .register(AppEvent.event1) { [weak self] in
        self?.somthingForEvent1()
    }
    .register(AppEvent.event2) { [weak self] in
        self?.somthingForEvent2()
    }
```
