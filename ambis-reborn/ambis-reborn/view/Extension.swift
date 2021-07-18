//
//  Extension.swift
//  ambis-reborn
//
//  Created by Rinaldi LNU on 06/07/21.
//

import SwiftUI

//struct ListBackgroundColor: ViewModifier {
//    let color: UIColor
//    func body(content: Content) -> some View {
//        content
//            .onAppear() {
//                UITableView.appearance().backgroundColor = self.color
//                UITableViewCell.appearance().backgroundColor = self.color
//            }
//    }
//}
//
//extension View {
//    func listBackgroundColor(color: UIColor) -> some View {
//        ModifiedContent(content: self, modifier: ListBackgroundColor(color: color))
//    }
//}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let colors = UINavigationBarAppearance()
        colors.backgroundColor = UIColor.init(Color("Gradient1"))
        
        navigationBar.standardAppearance = colors
        navigationBar.scrollEdgeAppearance = colors
        navigationBar.compactAppearance = colors
    }
}

extension View {
    func add(_ searchBar: SearchBar) -> some View {
        return self.modifier(SearchBarModifier(searchBar: searchBar))
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
