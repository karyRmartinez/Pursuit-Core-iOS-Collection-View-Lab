//
//  CountriesDetailViewController.swift
//  Collection-View-Lab
//
//  Created by Kary Martinez on 9/26/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import UIKit

class CountriesDetailViewController: UIViewController {

    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    
    var currentCountry: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
      
    }
    
    func setLabels() {
         countryName.text = currentCountry.name
        population.text = " \(currentCountry.population)"
    }
  

}
