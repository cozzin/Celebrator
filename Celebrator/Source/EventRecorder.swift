//
//  EventRecorder.swift
//  Celebrator
//
//  Created by 홍성호 on 03/08/2019.
//  Copyright © 2019 cozzin. All rights reserved.
//

import Foundation

struct EventRecorder {
    
    let repository: EventRepository
    
    func eventRecordKey(for event: Event) -> String {
        return "Celebrator.Event." + event.id
    }
    
    func needsCelebrate(for event: Event) -> Bool {
        return savedCount(for: event) == event.conditionCount
    }
    
    func savedInfo(for event: Event) -> [String: Any]? {
        return repository.dictionary(forKey: eventRecordKey(for: event))
    }
    
    func savedCount(for event: Event) -> Int {
        return savedInfo(for: event)?["count"] as? Int ?? 0
    }
    
    func newCount(for event: Event) -> Int {
        if event.conditionCount > savedCount(for: event) {
            return savedCount(for: event) + 1
        } else {
            return savedCount(for: event)
        }
    }
    
    func save(_ event: Event) {
        repository.set(["count": newCount(for: event)], forKey: eventRecordKey(for: event))
    }
}
