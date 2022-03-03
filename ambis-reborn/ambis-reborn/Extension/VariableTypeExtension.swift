//
//  VariableTypeExtension.swift
//  ExpiRemind
//
//  Created by Rinaldi LNU on 03/03/22.
//

import Foundation
import SwiftUI

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
