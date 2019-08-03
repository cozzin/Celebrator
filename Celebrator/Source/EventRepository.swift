//
//  EventRepository.swift
//  Celebrator
//
//  Created by 홍성호 on 03/08/2019.
//  Copyright © 2019 cozzin. All rights reserved.
//

import Foundation

public protocol EventRepository {
    func dictionary(forKey key: String) -> [String: Any]?
    func set(_ value: Any?, forKey: String)
}

extension UserDefaults: EventRepository { }
