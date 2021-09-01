//
//  DetailsInfoView.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 8.08.2021.
//


import UIKit
import Charts

final class DetailsInfoView: UIView {
    
    struct DetailsInfoViewVM {
        let isDown: Bool
        let isUp: Bool
        let bid: Float
        let channge: Float
        let count: Int
        let difference: Float
        let offer: Float
        let highest: Float
        let lowest: Float
        let maximum: Float
        let minimum: Float
        let price: Float
        let volume: Float
        let symbol: String
    }
    
    @IBOutlet weak var symbolValueLabel: UILabel!
    @IBOutlet weak var priceValueLabel: UILabel!
    @IBOutlet weak var percentDifferenceValueLabel: UILabel!
    @IBOutlet weak var transactionVolumeValueLabel: UILabel!
    @IBOutlet weak var buyingValueLabel: UILabel!
    @IBOutlet weak var salesValueLabel: UILabel!
    @IBOutlet weak var dailyLowValueLabel: UILabel!
    @IBOutlet weak var dailyHighValueLabel: UILabel!
    @IBOutlet weak var pieceValueLabel: UILabel!
    @IBOutlet weak var ceilingValueLabel: UILabel!
    @IBOutlet weak var baseValueLabel: UILabel!
    
   
 
    @IBOutlet weak var changeImageView: UIImageView!
    
    @IBOutlet weak var viewLineChart: LineChartView!
    
    var chart: LineChartView!
    var dataSet: LineChartDataSet!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
 
    }
    
    func configure(with viewModel: DetailsInfoViewVM) {
        symbolValueLabel.text =  viewModel.symbol.aesDecrypt()
        priceValueLabel.text = String(viewModel.price)
        percentDifferenceValueLabel.text =  String(viewModel.difference)
        transactionVolumeValueLabel.text = String(viewModel.volume)
        buyingValueLabel.text = String(viewModel.bid)
        salesValueLabel.text = String(viewModel.offer)
        dailyLowValueLabel.text =  String(viewModel.lowest)
        dailyHighValueLabel.text =  String(viewModel.highest)
        pieceValueLabel.text =  String(viewModel.count)
        ceilingValueLabel.text =  String(viewModel.maximum)
        baseValueLabel.text =  String(viewModel.minimum)
        
        if viewModel.isUp {
            changeImageView.image = UIImage(named:"up")!
        } else {
            changeImageView.image = UIImage(named:"down")!
        }
        
    }
    

}
