//
//  SinglePlayerViewController.swift
//  Pong
//
//  Created by Ozan Mirza on 12/28/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit

class SinglePlayerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.3) { [self] in
            tableView.alpha = tableView(tableView, numberOfRowsInSection: 0) > 0 ? 1 : 0
        }
    }
}

extension SinglePlayerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = History.shared.singlePlayerData.raw[indexPath.item]
        if data is String {
            return DayTableViewCell.height
        } else if data is Game {
            return HistoryTableViewCell.height
        } else {
            return AdTableViewCell.height
        }
    }
}

extension SinglePlayerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return History.shared.singlePlayerData.raw.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var data = History.shared.singlePlayerData.raw[indexPath.item]
        var cell: TableViewCell
        if data is String {
            cell = tableView.dequeueReusableCell(withIdentifier: "Day") as! DayTableViewCell
        } else if data is Game {
            cell = tableView.dequeueReusableCell(withIdentifier: "Game") as! HistoryTableViewCell
        } else {
            data = self
            cell = tableView.dequeueReusableCell(withIdentifier: "Ad") as! AdTableViewCell
        }
        cell.configure(with: data)
        return cell as! UITableViewCell
    }
}
