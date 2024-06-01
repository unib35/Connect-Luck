//
//  MainTabType.swift
//  FoodTruckApp3
//
//  Created by 이종민 on 5/25/24.
//

import Foundation
import SwiftUI

//CaseIterable : ForEach로 접근가능함
enum MainTabType : String, CaseIterable {
    case home
    case event
    case foodtruck
    case application
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .event:
            return "축제"
        case .foodtruck:
            return "푸드트럭"
        case .application:
            return "신청"
        }
    }
    
    
    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .event:
            return "party.popper"
        case .foodtruck:
            return "box.truck"
        case .application:
            return "doc.plaintext"
        }
    }

}
