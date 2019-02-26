//
//  AsyncImageView.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/24/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation
import UIKit
import Firebase

let imageCache = NSCache<NSString, AnyObject>()

public class AsyncImageView: UIImageView {
    
    var placeholderImage: UIImage?
    
    var firebaseURL: String? {
        didSet{
            self.image = placeholderImage
            
            //fetches image from storage
            if let firebaseURL = firebaseURL{
                let imageRef = Storage.storage().reference(forURL: firebaseURL)
                imageRef.getData(maxSize: 100*1024*1024, completion: { (data, error) in
                    if let data = data{
                        if let image = UIImage(data: data){
                            imageCache.setObject(image, forKey: firebaseURL as NSString)
                            self.image = image
                        }
                    }
                })
            }
        }
    }
    
    func setFirebaseURL(firebaseURL: String, placeholderImage: UIImage? = UIImage(color: UIColor.lightGray)) {
        if let cachedImage = imageCache.object(forKey: firebaseURL as NSString) as? UIImage{
            self.image = cachedImage
            return
        }
        
        if self.firebaseURL != firebaseURL{
            self.placeholderImage = placeholderImage
            self.firebaseURL = firebaseURL
        }
    }
    
}

