//
//  UIDevice.swift
//  AbsoluteFrameDemo
//
//  Created by Mykhailo Glagola on 14.07.2023.
//  Copyright © 2023 Mykhailo Glagola. All rights reserved.
//

import UIKit

extension UIDevice {
    var hasHomeButton: Bool? {
        guard let path = Bundle.main.path(forResource: "iPadInfo", ofType: "json"),
              let jsonData = FileManager.default.contents(atPath: path)
        else { return nil }
        do {
            let allDevicesInfo = try JSONDecoder().decode([Device].self, from: jsonData)
            let devicceIdentifier = identifier
            return allDevicesInfo.first(where: { $0.code == devicceIdentifier })?.info.homeButton
        } catch {
            print(error)
        }
        return nil

    }
    
    private var identifier: String {
        var systemInfo = utsname()
                uname(&systemInfo)
                let machineMirror = Mirror(reflecting: systemInfo.machine)
                let identifier = machineMirror.children.reduce("") { identifier, element in
                    guard let value = element.value as? Int8, value != 0 else { return identifier }
                    return identifier + String(UnicodeScalar(UInt8(value)))
                }
        return identifier
    }
    
}
