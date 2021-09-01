//
//  StockDetailViewController.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 7.08.2021.
//

import UIKit
import Charts
import CryptoSwift

class StockDetailViewController: UIViewController {


    

    
    private let detailView = DetailsInfoView()
    //private let detailLineChart = DetailsLineChartView()
    

    private var stock: StockDetailsResponse?
    
    init(stock: StockDetailsResponse) {
        self.stock = stock
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "IMKB Hisse ve Endeksler"
        view.backgroundColor = .systemBackground
        
        view.addSubview(detailView)
        
        
        configure()
        
    
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.height/4
        )
        

    }
    
    private func configure() {
        guard let stock = stock else {return}
        
        detailView.configure(
            with: DetailsInfoView.DetailsInfoViewVM(
                isDown: stock.isDown,
                isUp: stock.isUp,
                bid: stock.bid,
                channge: stock.channge,
                count: stock.count,
                difference: stock.difference,
                offer: stock.offer,
                highest: stock.highest,
                lowest: stock.lowest,
                maximum: stock.maximum,
                minimum: stock.minimum,
                price: stock.price,
                volume: stock.volume,
                symbol: stock.symbol)
        )
        
       
    }

    
    

    


}
