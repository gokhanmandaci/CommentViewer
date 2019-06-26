//
//  DownloaderButton.swift
//  Duuple
//
//  Created by Gökhan Mandacı on 26.12.2018.
//  Copyright © 2018 Gökhan Mandacı. All rights reserved.
//

import UIKit
import AlamofireImage

class DownloaderButton: UIButton {
    
    var imgUrlStr: String?
    
    func dlImage(urlString: String, placeholder: UIImage? = nil) {
        imgUrlStr = urlString
        self.setImage(placeholder, for: .normal)
        if let url = URL(string: urlString) {
            if let imgFromCache = dlImageCache.image(withIdentifier: urlString) {
                self.setImage(imgFromCache, for: .normal)
                self.imageView?.image = imgFromCache
                return
            }
            
            imageDownloader.download(URLRequest(url: url)) { response in
                if let responseValue = response.result.value {
                    if self.imgUrlStr == urlString {
                        self.setImage(responseValue, for: .normal)
                        dlImageCache.add(responseValue, withIdentifier: urlString)
                    }
                }
            }
        }
    }
    
    func dlBackgroundImage(urlString: String, placeholder: UIImage? = nil) {
        imgUrlStr = urlString
        self.setBackgroundImage(placeholder, for: .normal)
        if let url = URL(string: urlString) {
            if let imgFromCache = dlImageCache.image(withIdentifier: urlString) {
                self.setBackgroundImage(imgFromCache, for: .normal)
                self.imageView?.image = imgFromCache
                return
            }
            
            imageDownloader.download(URLRequest(url: url)) { response in
                if let responseValue = response.result.value {
                    if self.imgUrlStr == urlString {
                        self.setBackgroundImage(responseValue, for: .normal)
                        dlImageCache.add(responseValue, withIdentifier: urlString)
                    }
                }
            }
        }
    }
    
}
