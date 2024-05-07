//
//  ContinentTableViewCell.swift
//  GraphQLURLSession
//
//  Created by WhyQ on 03/05/24.
//

import UIKit

class ContinentTableViewCell: UITableViewCell {
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCode: UILabel!

    var continentValue:Continents? {
        didSet {//property observer
            productDetailConfiguration()
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration() {
        guard let continentValue else {
            return
        }
        countryName.text = "Continent Name:- " + continentValue.name
        countryCode.text = "Continent Code:- " + continentValue.code
    }
}
