//
//  BusRouteViewController.swift
//  BusRoute
//
//  Created by Mayank Mathur on 24/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import UIKit

//MARK: - UIViewController
class BusRouteViewController: UIViewController {

    @IBOutlet weak var busRouteTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var busRouteListArray: [BusRouteListModel]? = []
    var busRouteViewModel: BusRouteViewModel!
    var refreshTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        getBusRouteData()
    }
    
    func initialSetup() {
        spinner.startAnimating()
        refreshTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(refreshBusRouteList), userInfo: nil, repeats: true)
    }
    
    func getBusRouteData() {
        var busRoutesArray:[BusRouteListModel] = []
        busRouteViewModel = BusRouteViewModel()
        
        busRouteViewModel.fetchBusRouteDetails { [weak self] (result) in
            switch result {
            case .success(let route):
                busRoutesArray = route
            case .failure(let error):
                DispatchQueue.main.async {
                    UIAlertController.showAlert(title: "Error", message: error.localizedDescription, buttonOneTitle: "Okay", inViewController: self)
                }
            }
            
            self?.busRouteListArray = self?.busRouteViewModel.showOnlyFutureDateBuses(busRouteListModelArray: busRoutesArray)
            DispatchQueue.main.async {
                self?.busRouteTableView.reloadData()
                self?.spinner.stopAnimating()
            }
        }
    }
    
    @objc func refreshBusRouteList() {
        self.busRouteListArray = self.busRouteViewModel.showOnlyFutureDateBuses(busRouteListModelArray: busRouteListArray)
        DispatchQueue.main.async {
            self.busRouteTableView.reloadData()
        }
    }
    
    @IBAction func onTapNotificationButton(_ sender: UIButton) {
        UIAlertController.showAlert(title: "Info", message: "Tapped on the Notification bell", buttonOneTitle: "Okay", inViewController: self)
    }
    
    @IBAction func onTapBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        refreshTimer?.invalidate()
    }
}

//MARK: - UITableViewDataSource
extension BusRouteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busRouteListArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let routeCell = tableView.dequeueReusableCell(withIdentifier: "BusRouteTableViewCell") as? BusRouteTableViewCell, let busRouteObject = busRouteListArray?[indexPath.row] else {
            return UITableViewCell()
        }
        routeCell.configureCell(busRoute: busRouteObject)
        return routeCell
    }
}
