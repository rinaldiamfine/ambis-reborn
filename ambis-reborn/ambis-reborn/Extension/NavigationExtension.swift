//
//  NavigationExtension.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 03/03/22.
//

import Foundation
import SwiftUI

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        //SET FONT TO SF ROUNDED
        let design = UIFontDescriptor.SystemDesign.rounded
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
            .withDesign(design)!.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)!
        let fontLarge = UIFont(descriptor: descriptor, size: 38)
        let fontSmall = UIFont(descriptor: descriptor, size: 18)
        
        // SET BACKGROUND IN NAVBAR
        let navBar = UINavigationBarAppearance()
        let modalNavBar = UINavigationBarAppearance()
        let transparentNavBar = UINavigationBarAppearance()
        
        navBar.largeTitleTextAttributes = [.font : fontLarge]
        navBar.titleTextAttributes = [.font : fontSmall]
        transparentNavBar.largeTitleTextAttributes = [.font : fontLarge]
        transparentNavBar.titleTextAttributes = [.font : fontSmall]
        
        modalNavBar.largeTitleTextAttributes = [.font : fontLarge]
        modalNavBar.titleTextAttributes = [.font : fontSmall]
        
        navBar.backgroundColor = UIColor.init(Color("AppBackground"))
        navBar.shadowColor = .clear
        transparentNavBar.backgroundColor = .clear
        transparentNavBar.shadowColor = .clear
        
        navigationBar.standardAppearance = transparentNavBar
        navigationBar.scrollEdgeAppearance = navBar
        navigationBar.compactAppearance = navBar
    }
}
