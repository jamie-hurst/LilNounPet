//
//  Helpers.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI


extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension FileManager {
    static var sharedDocumentsDirectory: URL {
        let url = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.com.LilNounPet.shared")!
        return url
    }
}

//Dracula Pro theme for custom dark mode colors
extension ShapeStyle where Self == Color {
    
    static var dracWhite: Color {
        Color(red: 0.9725490196078431, green: 0.9725490196078431, blue: 0.9490196078431372)
    }
    
    static var dracBackground: Color {
        Color(red: 0.11372549019607843, green: 0.11764705882352941, blue: 0.14901960784313725)
    }
    
    static var dracPurple: Color {
        Color(red: 0.5843137254901961, green: 0.5019607843137255, blue: 1.0)
    }
    
    static var dracGreen: Color {
        Color(red: 0.5411764705882353, green: 1.0, blue: 0.5019607843137255)
    }

    static var dracCyan: Color {
        Color(red: 0.5019607843137255, green: 1.0, blue: 0.9176470588235294)
    }
    
    static var dracPink: Color {
        Color(red: 1.0, green: 0.5019607843137255, blue: 0.7490196078431373)
    }

    static var dracOrange: Color {
        Color(red: 1.0, green: 0.792156862745098, blue: 0.5019607843137255)
    }
    
    static var dracRed: Color {
        Color(red: 1.0, green: 0.5843137254901961, blue: 0.5019607843137255)
    }

    static var dracYellow: Color {
        Color(red: 1.0, green: 1.0, blue: 0.5019607843137255)
    }

}

extension UIImage {
    func createCompositeImage(layer2: UIImage, layer3: UIImage, layer4: UIImage, layer5: UIImage) -> UIImage {
        let bottomImage = self
        
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
        bottomImage.draw(in: areaSize)
        
        layer2.draw(in: areaSize, blendMode: .normal, alpha: 1.0)
        layer3.draw(in: areaSize, blendMode: .normal, alpha: 1.0)
        layer4.draw(in: areaSize, blendMode: .normal, alpha: 1.0)
        layer5.draw(in: areaSize, blendMode: .normal, alpha: 1.0)
        
        
        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return mergedImage
    }
     
    func resize(targetSize: CGSize, interpolationQuality: CGInterpolationQuality = .none) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { context in
            context.cgContext.interpolationQuality = interpolationQuality
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}


extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
