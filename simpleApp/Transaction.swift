//
//  Transaction.swift
//  simpleApp
//
//  Created by Son Dinh on 9/14/19.
//  Copyright © 2019 Son Dinh. All rights reserved.
//

import Foundation
import UIKit

struct Transaction: Codable {
    var store: String
    var total: Float
    var items: [String: Float]
    var dateTime: String
}

struct Result: Codable {
    var transactions: [Transaction]
}

