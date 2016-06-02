//
//  CategoriesViewController.swift
//  AftonbladetRSS
//
//  Created by Khalid Afridi on 02/06/16.
//  Copyright © 2016 Khalid Afridi. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    private var categories = [
        CategoriesModel(name: "Startsidan", link: "http://www.aftonbladet.se/rss.xml"),
        CategoriesModel(name: "Nyheter", link: "http://www.aftonbladet.se/nyheter/rss.xml"),
        CategoriesModel(name: "Sportbladet", link: "http://www.aftonbladet.se/sportbladet/rss.xml"),
        CategoriesModel(name: "Sportbladet Fotboll", link: "http://www.aftonbladet.se/sportbladet/fotboll/rss.xml"),
        CategoriesModel(name: "Sportbladet Hockey", link: "http://www.aftonbladet.se/sportbladet/hockey/rss.xml"),
        CategoriesModel(name: "Nöjesbladet", link: "http://www.aftonbladet.se/nojesbladet/rss.xml"),
        CategoriesModel(name: "Klick!", link: "http://www.aftonbladet.se/nojesbladet/klick/rss.xml"),
        CategoriesModel(name: "Kultur", link: "http://www.aftonbladet.se/kultur/rss.xml"),
        CategoriesModel(name: "Wellness", link: "http://www.aftonbladet.se/wellness/rss.xml")
    ]
    
    
    @IBOutlet weak var tableView : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "CategoryIdentifier" {
            let controller = segue.destinationViewController as! UINavigationController
            let rssViewController = controller.topViewController as! RSSTableViewController
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                rssViewController.category = categories[indexPath.row]
            }
        }
    }

}


extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryIdentifier", forIndexPath: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
}


extension CategoriesViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
