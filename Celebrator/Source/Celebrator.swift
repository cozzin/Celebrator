//
//  Celebrator.swift
//  Celebrator
//
//  Created by 홍성호 on 03/08/2019.
//  Copyright © 2019 cozzin. All rights reserved.
//

import Foundation

public class Celebrator {
    
    public typealias EventHandler = () -> Void
    
    private var events: [String: (Event, EventHandler)] = [:]
    private static let occurNotiName = NSNotification.Name("Celebrator.Event.Occur")
    private let recorder: EventRecorder
    
    public init(eventRepository: EventRepository = UserDefaults.standard) {
        recorder = EventRecorder(repository: eventRepository)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(celebrateIfNeeded),
            name: Celebrator.occurNotiName,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Celebrator.occurNotiName, object: nil)
    }
    
    public func occur(_ event: Event) {
        recorder.save(event)
        NotificationCenter.default.post(Notification(name: Celebrator.occurNotiName))
    }
    
    public func register(_ event: Event, handler: @escaping EventHandler) -> Celebrator {
        if recorder.needsCelebrate(for: event) {
            handler()
        }
        events[event.id] = (event, handler)
        return self
    }
    
    @objc
    private func celebrateIfNeeded() {
        events.values.forEach { event, handler in
            if recorder.needsCelebrate(for: event) {
                handler()
            }
        }
    }
}
