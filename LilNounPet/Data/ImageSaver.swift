//
//  ImageSaver.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 7/28/22.
//

import SwiftUI

class ImageSaver: NSObject {
    
    //writes to photo album and saves as a PNG file
    func writeToPhotoAlbum(image: UIImage) {
        guard let imageData = image.pngData() else { return }
        guard let pngImage = UIImage(data: imageData) else { return }
        
        UIImageWriteToSavedPhotosAlbum(pngImage, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
