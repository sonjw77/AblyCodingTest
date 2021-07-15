//
//  Utils.swift
//  AblyCodingTest
//
//  Created by alvin on 2021/07/13.
//

import UIKit

class Utils {

    /**
     현재 단말의 width 값을 구해온다.
     */
    static func getDisplayWidth() -> CGFloat {
        return (UIApplication.shared.windows.first?.rootViewController?.view.frame.size.width)!
    }
    
    /**
     현재 단말의 height 값을 구해온다.
     */
    static func getDisplayHeight() -> CGFloat {
        return (UIApplication.shared.windows.first?.rootViewController?.view.frame.size.height)!
    }

    /**
     현재 단말의 safeAreaInset 값을 구해온다.
     */
    static func getSafeLayoutInsets() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    /**
     int to  comma string
     */
    static func getCommaNumber(_ value:Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value:value))!
        
        return result
    }
}
