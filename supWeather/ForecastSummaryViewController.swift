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
        self.headerHeight = 400
        self.tableView.allowsSelection = false
    }


    
    @IBAction func closeSummaryController(sender: AnyObject) {
        popTransitionAnimation()
    }
    
    
}


// TableView Delegate & DataSource
extension ForecastSummaryTableViewController {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 120
        }
        
        return 70
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard indexPath.row > 0 else {
            let cell = cell as! HourlyForecastTableViewCell
            cell.hourly = self.forecast.hourly
            return
        }
    
        let forecast             = self.forecast.daily[indexPath.row - 1]
        let cell                 = cell as! DailyForecatTableViewCell
    
        cell.day.text            = forecast.dayOfWeek.name
        cell.icon.image          = forecast.type?.icon
        cell.temperatureMax.text = forecast.temperatureMax
        cell.temperatureMin.text = forecast.temperatureMin
        cell.summary.text        = forecast.type?.summary
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecast.daily.count + 1
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
