//
//  CarsCatalogueTableViewController.swift
//  CarsCatalogue
//
//  Created by Ekaterina Koreneva on 14/10/2019.
//  Copyright © 2019 Ekaterina. All rights reserved.
//

import UIKit
@IBDesignable class CarsCatalogueTableViewController: UITableViewController {

    var catalogue = Catalogue()
    var carEdited = Car(yearOfManufacture: "", brand: "", model: "", bodyType: "")
    private let year = YearOfManufacture()
    private var noData = "Нет данных"
    
    @IBAction func saveToCarCatalogueViewController (segue:UIStoryboardSegue) {
        let editCarViewController = segue.source as! CarDetailsTableViewController
        let editedCarIndex = editCarViewController.carIndexForEdit
        self.catalogue.cars[editedCarIndex] = carEdited

        tableView.reloadData()
        }

    @IBAction func pushAdd(_ sender: Any) {

        let alertController = UIAlertController(title: "Новая запись", message: nil, preferredStyle: .alert)
        alertController.addTextField { (yearOfManufacture) in
            yearOfManufacture.placeholder = "Год"
        }
        alertController.addTextField { (brand) in
            brand.placeholder = "Марка"
        }
        alertController.addTextField { (model) in
            model.placeholder = "Модель"
        }
        alertController.addTextField { (bodyType) in
            bodyType.placeholder = "Тип кузова"
        }
        let alertCancel = UIAlertAction(title: "Отменить", style: .cancel) { (alert) in
        }

        let alertAdd = UIAlertAction(title: "Добавить", style: .default) { (alert) in

            var newCarYear = self.noData
            var newCarBrand = self.noData
            var newCarModel = self.noData
            var newCarBodyType = self.noData

            for item in alertController.textFields!.indices {
                if alertController.textFields![item].text == "" {
                    alertController.textFields![item].text  = self.noData
                }
                switch item {
                case 0: newCarYear = alertController.textFields?[item].text ?? self.noData
                if !self.year.rangeForYear.contains(Int(newCarYear) ?? 0) {
                    newCarYear = "Неверный формат данных"
                    }
                case 1:  newCarBrand = (alertController.textFields?[item].text)!.capitalized
                case 2:  newCarModel = (alertController.textFields?[item].text)!.capitalized
                case 3:  newCarBodyType = (alertController.textFields?[item].text)!.capitalized
                default: break
                }
            }
                let newCar = Car (yearOfManufacture: newCarYear, brand: newCarBrand, model: newCarModel, bodyType: newCarBodyType)
                self.catalogue.addNewCar(newCar)
                self.tableView.reloadData()
        }
        alertController.addAction(alertAdd)
        alertController.addAction(alertCancel)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Автомобильный справочник"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.tableView:
            return self.catalogue.cars.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        let car = self.catalogue.cars[indexPath.row]
        cell.textLabel?.text = car.brand
        cell.detailTextLabel?.text = car.model
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.catalogue.cars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetailsIdentifier",
            let destination = segue.destination as? CarDetailsTableViewController,
        let carIndex = tableView.indexPathForSelectedRow?.row {
                destination.carDetails = self.catalogue.cars[carIndex]
            destination.carIndexForEdit = carIndex
        }
    }
}
