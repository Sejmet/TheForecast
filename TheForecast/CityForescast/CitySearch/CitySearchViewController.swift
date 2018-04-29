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
    var showFilteredCities: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchViewModel.populateCoreDataCityArray()
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            showFilteredCities = true
            searchViewModel.filterCityByName(cityName: searchText)
            cityTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            showFilteredCities = false
            cityTableView.reloadData()
        } else {
            showFilteredCities = true
            searchViewModel.filterCityByName(cityName: searchText)
            cityTableView.reloadData()
        }
    }
}

extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showFilteredCities {
            return searchViewModel.filteredCityArray.count
        } else {
            return searchViewModel.coreDataCityArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitySearchTableViewCell", for: indexPath) as! CitySearchTableViewCell
        if showFilteredCities {
            cell.setupCellWith(cityName: searchViewModel.filteredCityArray[indexPath.row].name)
        } else {
            cell.setupCellWith(cityName: searchViewModel.coreDataCityArray[indexPath.row].name)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = CityDetailViewController(nibName: "CityDetailViewController", bundle: nil)
        
        if showFilteredCities {
            detailVC.cityObject = searchViewModel.filteredCityArray[indexPath.row]
            searchViewModel.persistCity(cityObject: searchViewModel.filteredCityArray[indexPath.row])
        } else {
            detailVC.cityObject = searchViewModel.coreDataCityArray[indexPath.row]
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            searchViewModel.deleteCityFromPersistedModel(cityIndex: indexPath.row)
            searchViewModel.deleteCityFromCoreDataCityArray(cityIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}
