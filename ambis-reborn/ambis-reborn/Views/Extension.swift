//
//  Extension.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 06/07/21.
//

import SwiftUI

extension UserDefaults{
    func setRecipeLoad(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isRecipeLoad.rawValue)
    }

    func isRecipeLoad()-> Bool {
        return bool(forKey: UserDefaultsKeys.isRecipeLoad.rawValue)
    }
}

//struct CornerRadiusStyle: ViewModifier {
//    var radius: CGFloat
//    var corners: UIRectCorner
//    struct CornerRadiusShape: Shape {
//        var radius = CGFloat.infinity
//        var corners = UIRectCorner.allCorners
//        func path(in rect: CGRect) -> Path {
//            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//            return Path(path.cgPath)
//        }
//    }
//
//    func body(content: Content) -> some View {
//        content
//            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
//    }
//}

enum UserDefaultsKeys : String {
    case isRecipeLoad
}

//extension View {
//    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
//        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
//    }
//}
