//
//  RSSTableViewController.swift
//  AftonbladetRSS
//
//  Created by Khalid Afridi on 31/05/16.
//  Copyright © 2016 Khalid Afridi. All rights reserved.
//

import UIKit

class RSSTableViewController: UITableViewController {
    
    var dataTask: NSURLSessionDataTask?
    let RSS_URL = "http://www.aftonbladet.se/rss.xml"
    var rssFeeds = [RssFeed]()
    
    var currentElement = ""
    var rss_title : String = "" {
        didSet {
            rss_title = rss_title.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
    }
    var rss_pubDate : String = "" {
        didSet {
            rss_pubDate = rss_pubDate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if !rss_pubDate.isEmpty {
                let pubD = NSString(string: rss_pubDate)
                let pubD_Array = pubD.componentsSeparatedByString(" +")
                if pubD_Array.count > 0 {
                    rss_pubDate = pubD_Array[0] as String
                }
            }
        }
    }
    var rss_link : String = "" {
        didSet {
            rss_link = rss_link.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
    }
    var rss_image_link : String = "" {
        didSet {
            rss_image_link = rss_image_link.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            if !rss_image_link.isEmpty {
                let descString = NSString(string: rss_image_link)
                if descString.containsString("<img src=\"") {
                    let descArray = descString.componentsSeparatedByString("<img src=\"")
                    
                    if descArray.count > 0 {
                        let img_link_Array = descArray[1].componentsSeparatedByString(" \" />")
                        rss_image_link = img_link_Array[0] as String
                    }
                }
              
            }
            
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        
        startFetchingRSS()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        dataTask?.cancel()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rssFeeds.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("rssCellIdentifier", forIndexPath: indexPath) as! RssTableViewCell

        let rssFeed = rssFeeds[indexPath.row]
        
        cell.configureRssFeed(rssFeed)

        return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "webViewIdentifier" {
            let webView = segue.destinationViewController as! WebViewController
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                webView.rssFeed = rssFeeds[indexPath.row]
            }
            
        }
    }


}



extension RSSTableViewController: NSXMLParserDelegate {
    
    
    
    func startFetchingRSS() {
        
        let request = NSURLRequest(URL: NSURL(string: RSS_URL)!)
        let session = NSURLSession.sharedSession()
        
         dataTask = session.dataTaskWithRequest(request, completionHandler: {
            data, response, error in
            
            guard let data = data else {
                if let err = error {
                    print("Failure! \(err.localizedDescription)")
                }
                return
            }
            
            
            // Here we are safe to start parsing our xml
            let xmlParser = NSXMLParser(data: data)
            xmlParser.delegate = self
            xmlParser.parse()
            
            
            
        })
        
        // here by calling resume we send the request to the server
        dataTask!.resume()
    }

    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        currentElement = elementName
        
        // start of a new item tag
        if currentElement == "item" {
            rss_title = ""
            rss_pubDate = ""
            rss_link = ""
            rss_image_link = ""
        }
        
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title": rss_title += string
        case "pubDate": rss_pubDate += string
        case "link": rss_link += string
        case "description": rss_image_link += string
        
        default:
            break
        }
    }
    
    
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            let rssFeed = RssFeed()
            rssFeed.title = rss_title
            rssFeed.pubDate = rss_pubDate
            rssFeed.link = rss_link
            rssFeed.image_link = rss_image_link
            
            rssFeeds.append(rssFeed)
        }
    }

    func parserDidEndDocument(parser: NSXMLParser) {
        
        // call the reload table on main queue
        dispatch_async(dispatch_get_main_queue()) { 
            self.tableView.reloadData()
        }

    }
    
    
}






