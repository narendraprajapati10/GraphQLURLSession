//
//  ContinentsViewController.swift
//  GraphQLURLSession
//
//  Created by WhyQ on 03/05/24.
//

import UIKit

class ContinentsViewController: UIViewController {
    @IBOutlet weak var continentsTableView:UITableView!
    private var viewModel = ContinentsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
}

extension ContinentsViewController {
    func configuration() {
            continentsTableView.register(UINib(nibName: "ContinentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContinentTableViewCell")
        
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fatchProducts()
    }
    
    func observeEvent(){
        viewModel.eventHandler = {[weak self] event in
            guard self != nil else {
                return
            }
            switch event {
            case .loading:
                print("continents loading")
            case .stopLoading:
                print("stop loading")
            case .dataLoaded:
                    DispatchQueue.main.async {
                        self?.continentsTableView.reloadData()
                    }
            case .error(let error):
                print(error ?? "error is blank")
                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                        case .default:
                        print("default")
                        
                        case .cancel:
                        print("cancel")
                        
                        case .destructive:
                        print("destructive")
                        
                    @unknown default:
                        fatalError()
                    }
                }))
                self?.present(alert, animated: true, completion: nil)

            }
        }
    }
}

extension ContinentsViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.continents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "ContinentTableViewCell") as? ContinentTableViewCell else {
            return UITableViewCell()
        }
        let continent = viewModel.continents[indexPath.row]
        cell.continentValue = continent
        return cell
    }
}
