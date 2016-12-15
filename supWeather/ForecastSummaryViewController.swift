//
//  ForecastSummaryViewController.swift
//  supWeather
//
//  Created by Junior Boaventura on 14.12.16.
//  Copyright © 2016 Junior. All rights reserved.
//

import UIKit
import expanding_collection

class ForecastSummaryTableViewController: ExpandingTableViewController {
    
    var forecast: Place!

    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        // Do any additional setup after loading the view.
        self.headerHeight = 350
        self.tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func closeSummaryController(sender: AnyObject) {
        popTransitionAnimation()
    }
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 120
        }
        
        return 70
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            let cell = cell as! HourlyForecastTableViewCell
            cell.hourly = self.forecast.hourly
        }
        
        
        
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(HourlyForecastTableViewCell.identifier, forIndexPath: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(DailyForecatTableViewCell.identifier, forIndexPath: indexPath)
        return cell

    }

}
