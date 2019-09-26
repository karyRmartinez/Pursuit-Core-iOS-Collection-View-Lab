//
//  ViewController.swift
//  Collection-View-Lab
//
//  Created by Kary Martinez on 9/26/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var countryTable: UICollectionView!
    
    
    var Countries = [Country]() {
        didSet {
          countryTable.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTable.dataSource = self
        countryTable.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }

    private func loadData() {
        CountryAPIClient.manager.getCountry { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let CountryFromOnline):
                    self.Countries = CountryFromOnline
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return Countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countryTable.dequeueReusableCell(withReuseIdentifier: "cellOne", for: indexPath) as! CountryCollectionViewCell
        let currentCountry = Countries[indexPath.row]
        cell.countryName.text = currentCountry.name
        cell.population.text = "\(currentCountry.population)"
        cell.capital.text = currentCountry.capital
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
