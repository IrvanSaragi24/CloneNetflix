//
//  SearchViewController.swift
//  CloneNetflixFreeCodeCamp
//
//  Created by Irvan P. Saragi on 01/12/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    private var titles : [Title] = [Title]()
    
    
    private let discovredTable : UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private let searchController : UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "search film"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Top Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(discovredTable)
        
        discovredTable.delegate = self
        discovredTable.dataSource = self
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        fetchDiscoveredMovies()
        searchController.searchResultsUpdater = self
    }
    private func fetchDiscoveredMovies(){
        APICaller.shared.getDiscoverMovies {[weak self] results in
            switch results {
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.discovredTable.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discovredTable.frame = view.bounds
    }
    
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:TitleTableViewCell.identifier , for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: title.original_title ?? title.original_name ?? "Unknown", posterURL: title.poster_path ?? "No Poster")
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

extension SearchViewController :UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultViewController else {
            return
        }
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
