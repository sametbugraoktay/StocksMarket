//
//  StocksListTableViewCell.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 6.08.2021.
//


import UIKit
import CryptoSwift



class StocksListTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolValueLabel: UILabel!
    
    @IBOutlet weak var priceValueLabel: UILabel!
    
    
    @IBOutlet weak var differenceValueLabel: UILabel!
    
    @IBOutlet weak var volumeValueLabel: UILabel!
    
    
    @IBOutlet weak var salesValueLabel: UILabel!
    
    @IBOutlet weak var buyingValueLabel: UILabel!
    
    @IBOutlet weak var changeImageView: UIImageView!
    
    
    
    private var aesKey: String? {
        return UserDefaults.standard.string(forKey: "aesKey")
    }
    
    private var aesIV: String? {
        return UserDefaults.standard.string(forKey: "aesIV")
    }
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(stock: Stock?) {
        guard let stock = stock else { return }
        symbolValueLabel.text = stock.symbol
        priceValueLabel.text = String(stock.price)
        differenceValueLabel.text = String(stock.difference)
        volumeValueLabel.text = String(stock.volume)
        buyingValueLabel.text = String(stock.bid)
        salesValueLabel.text = String(stock.offer)
        
        if stock.isUp {
            changeImageView.image = UIImage(systemName: "chevron.up", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20, weight: .regular)))
            changeImageView.tintColor = .systemGreen
        }else {
            changeImageView.image = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20, weight: .regular)))
            changeImageView.tintColor = .systemRed
        }
    }

    


} 
