//
//  Extension.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 06/07/21.
//

import SwiftUI

extension View {
    func add(_ searchBar: SearchBar) -> some View {
        return self.modifier(SearchBarModifier(searchBar: searchBar))
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = UINavigationBarAppearance()
        let modalNavBar = UINavigationBarAppearance()
        
        //SET FONT TO SF ROUNDED
        let design = UIFontDescriptor.SystemDesign.rounded
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
            .withDesign(design)!.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)!
        let fontLarge = UIFont(descriptor: descriptor, size: 38)
        let fontSmall = UIFont(descriptor: descriptor, size: 17)
        
        navBar.largeTitleTextAttributes = [.font : fontLarge]
        navBar.titleTextAttributes = [.font : fontSmall]
        modalNavBar.largeTitleTextAttributes = [.font : fontLarge]
        modalNavBar.titleTextAttributes = [.font : fontSmall]
        
        navBar.backgroundColor = UIColor.init(Color("Gradient1"))
//        navBar.backgroundColor = UIColor.init(Color("AppBackground"))
        navBar.shadowColor = .clear
        
        navigationBar.standardAppearance = navBar
        navigationBar.scrollEdgeAppearance = navBar
        navigationBar.compactAppearance = navBar
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension String {
    func symbolToImage() -> UIImage {
        let size = CGSize(width: 38, height: 38)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 20)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}

extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

extension UserDefaults{

    func setRecipeLoad(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isRecipeLoad.rawValue)
    }

    func isRecipeLoad()-> Bool {
        return bool(forKey: UserDefaultsKeys.isRecipeLoad.rawValue)
    }

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

enum UserDefaultsKeys : String {
    case isRecipeLoad
extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
