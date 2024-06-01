//
//  FTAColor.swift
//  FoodTruckApp2
//
//  Created by 이종민 on 5/15/24.
//

import UIKit
import SwiftUI

enum FTAColor { }

extension FTAColor {
    enum UIKit {
        static var bk : UIColor = UIColor(named: "bk")!
        static var wh : UIColor = UIColor(named: "wh")!
        
        static var gray1 : UIColor = UIColor(named: "gray-1")!
        static var gary2 : UIColor = UIColor(named: "gray-2")!
        static var keyColorBlue : UIColor = UIColor(named: "key-color-blue")!
    }
}

extension FTAColor {
    enum SwiftUI {
        static var bk : Color = Color("bk", bundle: nil)
        static var wh: Color = Color("wh", bundle: nil)

        static var gray1: Color = Color("gray-1", bundle: nil)
        static var keyColorBlue: Color = Color("key-color-blue", bundle: nil)
        static var gray2: Color = Color("gray-2", bundle: nil)
        static var bkText: Color = Color("bk-text", bundle: nil)
        static var grayDeep : Color = Color("gray-deep", bundle: nil)
        static var grayLightVer2 : Color = Color("gray-light-ver2", bundle: nil)

    }
}
