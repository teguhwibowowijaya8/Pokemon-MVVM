//
//  PokemonListViewController.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

enum PokemonListSection: Int {
    case pokemonList
    case loader
}

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var pokemonListCollectionView: UICollectionView!
    
    private let spacing: CGFloat = 20
    
    private var pokemonListViewModel: PokemonListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Pokemons"
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupViewModel() {
        pokemonListViewModel = PokemonListViewModel()
        pokemonListViewModel?.delegate = self
        pokemonListViewModel?.getPokemonList()
    }
    
    func setupCollectionView() {
        pokemonListCollectionView.collectionViewLayout = collectionViewFlowLayout()
        pokemonListCollectionView.delegate = self
        pokemonListCollectionView.dataSource = self
        
        let pokemonCell = UINib(nibName: PokemonCollectionViewCell.identifier, bundle: nil)
        pokemonListCollectionView.register(pokemonCell, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
    }
    
    func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let viewWidth = self.view.bounds.width - spacing * 3
        
        let itemWidth: CGFloat
        if viewWidth / 2 > 200 { itemWidth = 200 }
        else { itemWidth = viewWidth / 2 }
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: 220)
        
        flowLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.minimumLineSpacing = spacing
        
        return flowLayout
    }
}

extension PokemonListViewController: PokemonListViewModelDelegate {
    func onPokemonListFetched(errorMessage: String?) {
        if let errorMessage = errorMessage {
            print(errorMessage)
        } else {
            DispatchQueue.main.async {
                self.pokemonListCollectionView.reloadData()
            }
        }
    }
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch PokemonListSection(rawValue: section) {
        case .pokemonList:
            return pokemonListViewModel?.currentCount ?? 0
            
        case .loader:
            let isLoading = pokemonListViewModel?.isLoading ?? false
            return isLoading ? 1 : 0
            
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pokemon: PokemonModel = pokemonListViewModel?.pokemons?.result[indexPath.row],
              let pokemonCell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell
        else { return UICollectionViewCell() }
        
        pokemonCell.setupCell(with: pokemon)
        
        return pokemonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let pokemon: PokemonModel = self.pokemonListViewModel?.pokemons?.result[indexPath.row],
            let pokemonDetailVC = storyboard.instantiateViewController(withIdentifier: PokemonDetailViewController.identifier) as? PokemonDetailViewController {

            pokemonDetailVC.detailUrl = pokemon.url
            self.navigationController?.pushViewController(pokemonDetailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let currCount = pokemonListViewModel?.currentCount,
              currCount > 0
        else { return }
        if indexPath.row == currCount - 1 {
            pokemonListViewModel?.getPokemonList()
        }
    }
}
