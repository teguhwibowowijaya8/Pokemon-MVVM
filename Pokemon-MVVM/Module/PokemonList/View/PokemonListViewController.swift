//
//  PokemonListViewController.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var pokemonListCollectionView: UICollectionView!
    
    private let horizontalSpacing: CGFloat = 20
    private let verticalSpacing: CGFloat = 10
    
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
        
        let viewWidth = self.view.bounds.width - horizontalSpacing * 3
        flowLayout.itemSize = CGSize(width: viewWidth / 2, height: 220)
        
        flowLayout.sectionInset = UIEdgeInsets(top: verticalSpacing, left: horizontalSpacing, bottom: verticalSpacing, right: horizontalSpacing)
        flowLayout.minimumInteritemSpacing = horizontalSpacing
        flowLayout.minimumLineSpacing = verticalSpacing
        
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
        return pokemonListViewModel?.pokemons?.result.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pokemon = pokemonListViewModel?.pokemons?.result[indexPath.row],
              let pokemonCell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell
        else { return UICollectionViewCell() }
        
        pokemonCell.delegate = self
        pokemonCell.setupCell(with: pokemon)
        
        return pokemonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let pokemonDetailVC = storyboard.instantiateViewController(withIdentifier: PokemonDetailViewController.identifier) as? PokemonDetailViewController {
            self.navigationController?.pushViewController(pokemonDetailVC, animated: true)
        }
    }
}

extension PokemonListViewController: PokemonCollectionCellDelegate {
    func getImageURL(of detailUrl: String, onCompletion: @escaping (String?) -> Void) {
        self.pokemonListViewModel?.getPokemonDetailImage(of: detailUrl, onCompletion: onCompletion)
    }
}
