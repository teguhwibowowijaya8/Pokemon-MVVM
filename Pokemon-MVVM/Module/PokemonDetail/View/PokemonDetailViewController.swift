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
    
    var detailUrl: String?
    private var pokemonDetailViewModel: PokemonDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewModel()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Pokemon Detail"
    }
    
    func setupViewModel() {
        guard let detailUrl = detailUrl else { return }
        pokemonDetailViewModel = PokemonDetailViewModel(url: detailUrl)
        pokemonDetailViewModel?.delegate = self
        pokemonDetailViewModel?.getDetail()
    }
    
    func setupTableView() {
        pokemonDetailTableView.delegate = self
        pokemonDetailTableView.dataSource = self
        pokemonDetailTableView.separatorStyle = .none
        
        let detailHeaderCell = UINib(nibName: DetailHeaderTableViewCell.identifier, bundle: nil)
        pokemonDetailTableView.register(detailHeaderCell, forCellReuseIdentifier: DetailHeaderTableViewCell.identifier)
        
        let detailMoveCell = UINib(nibName: DetailMoveTableViewCell.identifier, bundle: nil)
        pokemonDetailTableView.register(detailMoveCell, forCellReuseIdentifier: DetailMoveTableViewCell.identifier)
    }
}

extension PokemonDetailViewController: PokemonDetailProtocol {
    func onPokemonDetailFetched(errorMessage: String?) {
        DispatchQueue.main.async {
            self.pokemonDetailTableView.reloadData()
        }
    }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch PokemonDetailSection(section) {
        case .header:
            return 1
        case .moves:
            return pokemonDetailViewModel?.pokemonDetail?.moves.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonDetail = pokemonDetailViewModel?.pokemonDetail
        else { return UITableViewCell() }
        switch PokemonDetailSection(indexPath.section) {
        case .header:
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderTableViewCell.identifier, for: indexPath) as? DetailHeaderTableViewCell
            else { return UITableViewCell() }
            
            headerCell.setupCell(
                name: pokemonDetail.name,
                health: pokemonDetail.health,
                imageUrlString: pokemonDetail.sprites.imageUrlString)
            
            return headerCell
            
        case .moves:
            guard let moveCell = tableView.dequeueReusableCell(withIdentifier: DetailMoveTableViewCell.identifier, for: indexPath) as? DetailMoveTableViewCell
            else { return UITableViewCell() }
            
            let move = pokemonDetail.moves[indexPath.row].move
            moveCell.setupCell(
                moveName: move.name, moveDetail: move.moveDetail)
            
            return moveCell
            
        }
    }
}
