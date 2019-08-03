//
//  CelebratorTests.swift
//  CelebratorTests
//
//  Created by 홍성호 on 03/08/2019.
//  Copyright © 2019 cozzin. All rights reserved.
//

import XCTest
import Celebrator

class CelebratorTests: XCTestCase {
    
    final class FakeEventRepository: EventRepository {
        
        private var data: [String: Any] = [:]
        
        init() { }
        
        func dictionary(forKey key: String) -> [String : Any]? {
            return data[key] as? [String : Any]
        }
        
        func set(_ value: Any?, forKey key: String) {
            data[key] = value
        }
    }

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
    
    var didCelebrateEvent1: Bool = false
    var didCelebrateEvent2: Bool = false
    var celebrator: Celebrator!
    
    override func setUp() {
        celebrator = Celebrator(eventRepository: FakeEventRepository())
            .register(AppEvent.event1) { [weak self] in
                self?.didCelebrateEvent1 = true
            }
            .register(AppEvent.event2) { [weak self] in
                self?.didCelebrateEvent2 = true
            }
    }

    override func tearDown() {
        didCelebrateEvent1 = false
        didCelebrateEvent2 = false
    }

    func testCelebrateEvent_whenConditionSatisfied() {
        celebrator.occur(AppEvent.event1)
        XCTAssertTrue(didCelebrateEvent1)
        
        celebrator.occur(AppEvent.event2)
        celebrator.occur(AppEvent.event2)
        XCTAssertTrue(didCelebrateEvent2)
    }
    
    func testCelebrateEvent_whenConditionNotSatisfied() {
        XCTAssertFalse(didCelebrateEvent1)
        
        celebrator.occur(AppEvent.event2)
        XCTAssertFalse(didCelebrateEvent2)
    }
}
