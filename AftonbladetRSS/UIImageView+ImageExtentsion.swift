//
//  UIImageView+ImageExtentsion.swift
//  AftonbladetRSS
//
//  Created by Khalid Afridi on 02/06/16.
//  Copyright © 2016 Khalid Afridi. All rights reserved.
//

import UIKit


extension UIImageView {
    func loadImageWithURL(url: NSURL) -> NSURLSessionDownloadTask {
        let session = NSURLSession.sharedSession()
        
        let task = session.downloadTaskWithURL(url, completionHandler: { [weak self] url, response, err in
            
            if err == nil {
                if let url = url {
                    if let data = NSData(contentsOfURL: url), image = UIImage(data: data) {
                        
                        dispatch_async(dispatch_get_main_queue(), { 
                            if let strSelf = self {
                                strSelf.image = image
                            }
                        })
                    }
                }
            }
            
        })
        task.resume()
        return task
    }
}
