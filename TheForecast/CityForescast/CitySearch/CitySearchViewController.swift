//
//  CitySearchViewController.swift
//  TheForecast
//
//  Created by Maria Belen Marañon on 27/4/18.
//  Copyright © 2018 IT Crowd Challenge. All rights reserved.
//

import UIKit

class CitySearchViewController: UIViewController {

    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    func setupTableView() {
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        cityTableView.estimatedRowHeight = 80
        cityTableView.rowHeight = UITableViewAutomaticDimension
        
        cityTableView.register(UINib(nibName: "CitySearchTableViewCell", bundle: nil), forCellReuseIdentifier: "CitySearchTableViewCell")
    }

}

extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitySearchTableViewCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
