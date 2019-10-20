//
//  CarDetailsTableViewController.swift
//  CarsCatalogue
//
//  Created by Ekaterina Koreneva on 15/10/2019.
//  Copyright © 2019 Ekaterina. All rights reserved.
//

import UIKit

class CarDetailsTableViewController: UITableViewController {
    var carDetails = Car(yearOfManufacture: "", brand: "", model: "", bodyType: "")
    var carIndexForEdit = Int()
    
    @IBAction func saveToCarDetailsViewController (segue:UIStoryboardSegue) {
        let editDetailViewController = segue.source as! EditDetailsTableViewController
        let index = editDetailViewController.propertyForEdit
        
        switch index {
        case 0: carDetails.yearOfManufacture = editDetailViewController.detail
        case 1: carDetails.brand = editDetailViewController.detail
        case 2: carDetails.model = editDetailViewController.detail
        case 3: carDetails.bodyType = editDetailViewController.detail
        default: print("No data updated")
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCellIdentifier", for: indexPath)
        switch indexPath.row {
        case 0: cell.textLabel?.text = carDetails.yearOfManufacture
        case 1: cell.textLabel?.text = carDetails.brand
        case 2: cell.textLabel?.text = carDetails.model
        case 3: cell.textLabel?.text = carDetails.bodyType
        default: cell.textLabel?.text = "Нет информации"
        }
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit",
            let destination = segue.destination as? EditDetailsTableViewController,
            let detailIndex = tableView.indexPathForSelectedRow?.row {
            destination.propertyForEdit = detailIndex
            switch detailIndex {
            case 0: destination.detail = carDetails.yearOfManufacture
            case 1: destination.detail = carDetails.brand
            case 2: destination.detail = carDetails.model
            case 3: destination.detail = carDetails.bodyType
            default: destination.detail = "Нет информации"
            }
        } else if segue.identifier == "saveToCatalogue" {
             let destination = segue.destination as? CarsCatalogueTableViewController
            destination!.carEdited = carDetails
            print("Car edited details are \(carDetails)")
        }

    }
}

