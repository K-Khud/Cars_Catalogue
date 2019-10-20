//
//  Catalogue.swift
//  CarsCatalogue
//
//  Created by Ekaterina Koreneva on 04/10/2019.
//  Copyright © 2019 Ekaterina. All rights reserved.
//

import Foundation

class Catalogue {
    var cars: [Car] {
        set {
            saveToFile(newValue)
        }
        get {
            if let array = loadFromFile() {
                return array
            } else {
                return defaultCars
            }
        }
    }

    private let defaultCars: [Car] = [
    Car(yearOfManufacture: "1991", brand: "Honda", model: "City", bodyType: "Хэтчбэк"),
    Car(yearOfManufacture: "2015", brand: "Toyota", model: "Tundra", bodyType: "Пикап"),
    Car(yearOfManufacture: "2009", brand: "Nissan", model: "GTR", bodyType: "Купе")
    ]
       
    func addNewCar(_ car: Car) {
        if !self.cars.contains(car) {
            self.cars.append(car)
        } else {
            print("\(car) is already in the Catalogue")
        }
    }
   
    private func getPath() -> URL? {
        guard let cachesPath = try? FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true) else {
            print("CachesPath error")
            return nil
        }
        let path = cachesPath.appendingPathComponent("CarCatalogue.txt", isDirectory: false)
        print("Path OK")
        return path
    }
    
    func deleteCar(_ car: Car) {
        if let indexForRemove = self.cars.firstIndex(of: car) {
            self.cars.remove(at: indexForRemove)
            saveToFile(self.cars)
        } else {
            print("Element \(car) is not found and cannot be deleted")
        }
    }
        
    private func saveToFile(_ carsForSave: [Car]) {
        let encodedData = try? JSONEncoder().encode(carsForSave)
        if let path = getPath() {
            if FileManager.default.fileExists(atPath: path.path) {
                do {
                    try encodedData!.write(to: path)
                    print("Succeded to write data to path: \(path.path)")
                } catch {
                    print("Failed to write data to path: \(error.localizedDescription)")
                }
            } else {
                let newFile = FileManager.default.createFile(atPath: path.path, contents: encodedData, attributes: nil)
                print("file created when saving attempt: \(newFile)")
            }
        }
    }
    private func loadFromFile() -> [Car]? {
        if let path = getPath() {
            if FileManager.default.fileExists(atPath: path.path) {
                do {
                    let data = try Data(contentsOf: path, options:.mappedIfSafe)
                    let carsFromFile = try JSONDecoder().decode([Car].self, from: data)
                    print("Cars are taken from file: \(carsFromFile)")
                    return carsFromFile
                } catch {
                    print("Decoder failed during loadFromFile, no data in file: \(error.localizedDescription)")
                }
            }
        }
        return nil
    }
}
