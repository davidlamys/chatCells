//
//  MasterViewController.swift
//  test
//
//  Created by David Lam on 14/2/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var configuartors: [DetailViewConfigurator] = [DetailViewConfigurator]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        let nib = UINib(nibName: "IncomingCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "IncomingCell")
        tableView.register(nib, forCellReuseIdentifier: "IncomingTextCell")
 
        let nib2 = UINib(nibName: "OutgoingCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "OutgoingCell")
        tableView.register(nib2, forCellReuseIdentifier: "OutgoingTextCell")
        
        let base = [
                         DetailViewConfigurator(showImage: true, textType: .shortText, messageType:.received),
                         DetailViewConfigurator(showImage: true, textType: .mediumText, messageType:.received),
                         DetailViewConfigurator(showImage: true, textType: .longText, messageType:.received),
                         
                         DetailViewConfigurator(showImage: false, textType: .shortText, messageType:.received),
                         DetailViewConfigurator(showImage: false, textType: .mediumText, messageType:.received),
                         DetailViewConfigurator(showImage: false, textType: .longText, messageType:.received),
                         
                         DetailViewConfigurator(showImage: true, textType: .shortText, messageType:.sent),
                         DetailViewConfigurator(showImage: true, textType: .mediumText, messageType:.sent),
                         DetailViewConfigurator(showImage: true, textType: .longText, messageType:.sent),
                         
                         DetailViewConfigurator(showImage: false, textType: .shortText, messageType:.sent),
                         DetailViewConfigurator(showImage: false, textType: .mediumText, messageType:.sent),
                         DetailViewConfigurator(showImage: false, textType: .longText, messageType:.sent)
            ]
        
        for _ in 0..<50 {
            configuartors += base
        }
        
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let lastRow = self.configuartors.count - 1
        let indexPath = IndexPath(row: lastRow, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = configuartors[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.configurator = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configuartors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let configuartor = configuartors[indexPath.row]
        
        if configuartor.messageType == .received {
            if configuartor.showImage {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingCell", for: indexPath) as! IncomingCell
                cell.configurator = configuartor
                cell.configureCell()
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingTextCell", for: indexPath) as! IncomingCell
                cell.configurator = configuartor
                cell.configureCell()
                return cell
            }
        } else {
            if configuartor.showImage {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingCell", for: indexPath) as! OutgoingCell
            cell.configuator = configuartor
            cell.configureView()
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingTextCell", for: indexPath) as! OutgoingCell
                cell.configuator = configuartor
                cell.configureView()
                cell.removeMediaView()
                return cell
            }
        
        }
        
    }

}

