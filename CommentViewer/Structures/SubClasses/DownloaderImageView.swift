//
//  DownloaderImageView.swift
//  Duuple
//
//  Created by Gökhan Mandacı on 24.09.2018.
//  Copyright © 2018 Gökhan Mandacı. All rights reserved.
//

import UIKit
import AlamofireImage

class DownloaderImageView: UIImageView {
    
    var imgUrlStr: String?
    
    func dlImage(urlString: String, placeholder: UIImage? = nil) {
        imgUrlStr = urlString
        image = placeholder
        if let url = URL(string: urlString) {
            if let imgFromCache = dlImageCache.image(withIdentifier: urlString) {
                self.image = imgFromCache
                return
            }
            
            imageDownloader.download(URLRequest(url: url)) { response in
                if let responseValue = response.result.value {
                    if self.imgUrlStr == urlString {
                        self.image = responseValue
                        dlImageCache.add(responseValue, withIdentifier: urlString)
                    }
                }
            }
        }
    }
    
}
