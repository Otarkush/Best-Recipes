//
//  Resources.swift
//  Best Recipes
//
//  Created by Alexander on 2.07.24.
//

import UIKit

enum Resources {
    enum Colors {
        static var black = UIColor(hexString: "#181818")
        static var white = UIColor(hexString: "FCFCFC")
        static var lightGray = UIColor(hexString: "#C1C1C1")
        static var darkGray = UIColor(hexString: "#919191 ")
        static var red = UIColor(hexString: "#E23E3E")
        static var rose = UIColor(hexString: "#F3B2B2")
        static var lightOrange = UIColor(hexString: "##F8C89A")
        
        //background colors
        static var backgroundWhite = UIColor(hexString: "#FFFFFF")
        static var backgroundGray = UIColor(hexString: "#F1F1F1")
        
        static var roseBackTabBar = UIColor(hexString: "#F9D8D8")
        static var redBorderTabBar = UIColor(hexString: "#E23E3E")
    }
    
    enum Images {
        enum TabBar {
            static var home = UIImage(named: "homeIcon")
            static var bookmark = UIImage(named: "bookmarkIcon")
            static var notification = UIImage(named: "notificationIcon")
            static var profile = UIImage(named: "profileIcon")
        }
        
        enum Onboarding {
            static var first = UIImage(named: "obFirst")
            static var second = UIImage(named: "obSecond")
            static var third = UIImage(named: "obThird")
            static var fourth = UIImage(named: "obFourth")
        }
    }
    
    enum Fonts {
        static func poppinsRegular(of size: CGFloat) -> UIFont {
            UIFont(name: "Poppins-Regular", size: size) ?? UIFont()
        }
        static func poppinsBold(of size: CGFloat) -> UIFont {
            UIFont(name: "Poppins-Bold", size: size) ?? UIFont()
        }
        
    }
    
}

//"Poppins-Regular", "Poppins-Bold"
