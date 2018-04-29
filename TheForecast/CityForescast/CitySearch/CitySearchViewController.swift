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
    
    let searchViewModel: CitySearchViewModel = CitySearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupSearchBar()
    }

    func setupTableView() {
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        cityTableView.estimatedRowHeight = 80
        cityTableView.rowHeight = UITableViewAutomaticDimension
        
        cityTableView.register(UINib(nibName: "CitySearchTableViewCell", bundle: nil), forCellReuseIdentifier: "CitySearchTableViewCell")
    }
    
    func setupSearchBar() {
        searchViewModel.populateCityArray()
        citySearchBar.delegate = self
    }

}

extension CitySearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel.filterCityByName(cityName: searchText)
        cityTableView.reloadData()
    }
}

extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.filteredCityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitySearchTableViewCell", for: indexPath) as! CitySearchTableViewCell
        
        cell.setupCellWith(cityName: searchViewModel.filteredCityArray[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = CityDetailViewController(nibName: "CityDetailViewController", bundle: nil)
        detailVC.cityObject = searchViewModel.filteredCityArray[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
