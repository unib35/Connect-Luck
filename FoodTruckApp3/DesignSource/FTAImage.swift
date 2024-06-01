//
//  FTAImage.swift
//  FoodTruckApp2
//
//  Created by 이종민 on 5/15/24.
//

import UIKit
import SwiftUI

enum FTAImage { }

extension FTAImage {
    enum UIKit {
        static var buttonComplete: UIImage = UIImage(resource: .btnComplete)
        static var buttonActivate: UIImage = UIImage(resource: .btnActivate)
        
        static var topBtn : UIImage = UIImage(resource: .topBtn)
        static var home : UIImage = UIImage(resource: .home)
        static var left : UIImage = UIImage(resource: .left)
        static var next : UIImage = UIImage(resource: .next)
        static var down : UIImage = UIImage(resource: .down)
        static var close : UIImage = UIImage(resource: .close)
        
        
        //favorite
        static var favoriteOn : UIImage = UIImage(resource: .favoriteOn)
        static var favoriteOff : UIImage = UIImage(resource: .favoriteOff)
        
        //categories
        static var category1Big : UIImage = UIImage(resource: .category1Big)
    }
    
}

extension FTAImage{
    enum SwiftUI {
        static var back : Image = Image("back")
        static var profile : Image = Image("profile")
    }
}
