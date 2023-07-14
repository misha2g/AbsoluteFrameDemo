//
//  DeviceInfo.swift
//  AbsoluteFrameDemo
//
//  Created by Mykhailo Glagola on 14.07.2023.
//  Copyright © 2023 Mykhailo Glagola. All rights reserved.
//

import Foundation

struct Device: Decodable {
    struct DeviceInfo: Decodable {
        let fullNmame: String
        let homeButton: Bool
    }
    let code: String
    let info: DeviceInfo
}
