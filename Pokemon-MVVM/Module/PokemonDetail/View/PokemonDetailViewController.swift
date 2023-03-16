//
//  PokemonDetailViewController.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

enum PokemonDetailSection: Int {
    case header
    case moves
    
    init(_ section: Int) {
        switch section {
        case 0:
            self = .header
        case 1:
            self = .moves
        default:
            self = .header
        }
    }
}

class PokemonDetailViewController: UIViewController {
    
    static let identifier = "PokemonDetailViewController"
    
    @IBOutlet weak var pokemonDetailTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Pokemon Detail"
    }
    
    func setupViewModel() {
        
    }
    
    func setupTableView() {
        pokemonDetailTableView.delegate = self
        pokemonDetailTableView.dataSource = self
        
        let detailHeaderCell = UINib(nibName: DetailHeaderTableViewCell.identifier, bundle: nil)
        pokemonDetailTableView.register(detailHeaderCell, forCellReuseIdentifier: DetailHeaderTableViewCell.identifier)
        
        let detailMoveCell = UINib(nibName: DetailMoveTableViewCell.identifier, bundle: nil)
        pokemonDetailTableView.register(detailMoveCell, forCellReuseIdentifier: DetailMoveTableViewCell.identifier)
    }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
