//
//  StocksListViewController.swift
//  VeriparkApp
//
//  Created by Samet Bugra Oktay on 6.08.2021.
//

import UIKit
import SideMenu
import CryptoSwift



class StocksListViewController: UIViewController, UISearchBarDelegate {
  
 
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
 
    @IBOutlet weak var symbolValueLabel: UILabel!
    
    @IBOutlet weak var priceValueLabel: UILabel!
    
    @IBOutlet weak var differenceValueLabel: UILabel!
    
    @IBOutlet weak var volumeValueLabel: UILabel!
    
    @IBOutlet weak var buyingValueLabel: UILabel!
    

    @IBOutlet weak var salesValueLabel: UILabel!
    
    @IBOutlet weak var changeValueLabel: UILabel!
    
    var menu: SideMenuNavigationController?
    
    private var stocks: [Stock]?
   
    private var filteredStocks = [Stock]()
    var isSearch = false


 
    var period = "all"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        configured()
      
        let vc = MenuListController()
        vc.delegate = self
        menu = SideMenuNavigationController(rootViewController: vc)
        setupMenu()
        
        APICaller.shared.fetchStocks(period: period ,completion: {[weak self] result in
            switch result {
            case .success(let stocks):
                DispatchQueue.main.async {
                    print("Success")
                    self?.tableView.isHidden = false
                    self?.stocks = stocks
                    self?.tableView.reloadData()
                }
            case .failure(_): print("Error.Stocks didn't loaded")
                break
            }
        })

    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearch = true
        filteredStocks = (stocks?.filter { (stock: Stock) -> Bool in
            return stock.symbol.lowercased().contains(searchText.lowercased())
        })!
        tableView.reloadData()
    }
    
    private func configured() {

        searchBar.delegate = self
       
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    //setup navigation bar
    private func setupNavbar() {
        title = "IMKB Hisse ve Endeksler"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3"),
            style: .plain,
            target: self,
            action: #selector(didTapMenu)
        )
        navigationItem.leftBarButtonItem?.tintColor = .label
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.hidesBackButton = true
        
    }
    
    //setup menu
    private func setupMenu() {
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: true)
        ///slide left touch
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    //MARK: - Objc funcs
    
    @objc private func didTapMenu() {
        let vc = MenuListController()
        vc.delegate = self
        present(menu!, animated: true)
    }
    
    
 
}

extension StocksListViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSearch == true)
        {
            return filteredStocks.count
        }
        return stocks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "StocksListTableViewCell",
            for: indexPath
        ) as? StocksListTableViewCell
        else
        {
            return UITableViewCell()
        }
        if indexPath.row%2 == 0
        {
            cell.backgroundColor = .systemBackground
        } else
        {
            cell.backgroundColor = .systemGray6
        }
 
        let stock: Stock
        if (isSearch == true)
        {
            stock = filteredStocks[indexPath.row]
        } else
        {
            stock = (stocks?[indexPath.row])!
        }
        
        cell.configure(stock: stock)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let stock = stocks?[indexPath.row] else {return}
        let id = String(stock.id)
        APICaller.shared.getDetailsStock(with: id, completion: {[weak self] result in
            switch result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let stock):
                DispatchQueue.main.async {
                    
                    let vc = StockDetailViewController(stock: stock)
                    vc.modalPresentationStyle = .fullScreen
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        })


    }
    

    
   
}


//MARK: - Menu Actions
extension StocksListViewController: MenuListControllerDelegate {
    //click menu cell actions
    func clickedMenu(with period: String) {
        self.period = period
        APICaller.shared.fetchStocks(period: period ,completion: {[weak self] result in
            switch result {
            case .success(let stocks):
                DispatchQueue.main.async {
                    self?.stocks = stocks
                    self?.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        })
    }
}






