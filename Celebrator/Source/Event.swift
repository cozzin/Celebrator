//
//  Event.swift
//  Celebrator
//
//  Created by 홍성호 on 03/08/2019.
//  Copyright © 2019 cozzin. All rights reserved.
//

import Foundation

public protocol Event {
    var id: String { get }
    var conditionCount: Int { get }
}
