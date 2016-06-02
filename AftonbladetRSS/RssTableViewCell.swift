//
//  RssTableViewCell.swift
//  AftonbladetRSS
//
//  Created by Khalid Afridi on 01/06/16.
//  Copyright © 2016 Khalid Afridi. All rights reserved.
//

import UIKit

class RssTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var pubDateLabel : UILabel!
    @IBOutlet weak var rss_imageView : UIImageView!
    
    var task: NSURLSessionDownloadTask?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func configureRssFeed(rssFeed: RssFeed) {
        titleLabel.text = rssFeed.title
        pubDateLabel.text = rssFeed.pubDate
        
        rss_imageView.image = UIImage(named: "noimage")
        if !rssFeed.image_link.isEmpty {
            if let url = NSURL(string: rssFeed.image_link) {
                task = rss_imageView.loadImageWithURL(url)
            }
        }
    }
    

}
