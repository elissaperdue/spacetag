//
//  LocationFile.swift
//  nav
//
//  Created by Elissa Perdue on 8/1/20.
//  Copyright © 2020 Elissa Perdue. All rights reserved.
//

import Foundation

import Foundation
import UIKit
@testable import nav

struct LocationTag {
    var name: String
    var latitude: Double
    var longitude: Double
}


var all: [LocationTag] {
    return [LocationTag(name: "aLoc", latitude: 80.0, longitude: -40.32)]
}
