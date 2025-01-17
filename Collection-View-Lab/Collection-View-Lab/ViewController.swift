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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let specificCountry = Countries[indexPath.row]
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailVC") as! CountriesDetailViewController
        
        detailVC.currentCountry = specificCountry
     
        self.navigationController?.pushViewController(detailVC, animated: true)
        
//        print("You have selected \(Countries[indexPath.row])")
    }
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
        
        ImageHelper.shared.getImage(urlStr: currentCountry.ImageURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    cell.countryImage.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
