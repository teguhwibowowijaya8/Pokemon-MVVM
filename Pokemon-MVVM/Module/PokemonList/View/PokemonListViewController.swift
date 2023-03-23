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
    case error
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
        pokemonListViewModel?.getPokemonList(reloadLoader: false)
    }
    
    func setupCollectionView() {
        pokemonListCollectionView.isUserInteractionEnabled = true
        pokemonListCollectionView.collectionViewLayout = collectionViewFlowLayout()
        pokemonListCollectionView.delegate = self
        pokemonListCollectionView.dataSource = self
        
        let pokemonCell = UINib(nibName: PokemonCollectionViewCell.identifier, bundle: nil)
        pokemonListCollectionView.register(pokemonCell, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        
        pokemonListCollectionView.register(LoaderCollectionViewCell.self, forCellWithReuseIdentifier: LoaderCollectionViewCell.identifier)
        
        pokemonListCollectionView.register(ErrorCollectionViewCell.self, forCellWithReuseIdentifier: ErrorCollectionViewCell.identifier)
    }
    
    func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        return flowLayout
    }
}

extension PokemonListViewController: PokemonListViewModelDelegate {
    func onPokemonListFetched() {
        if pokemonListViewModel?.errorMessage != nil {
            DispatchQueue.main.async {
                self.pokemonListCollectionView.reloadSections(IndexSet([
                    PokemonListSection.loader.rawValue,
                    PokemonListSection.error.rawValue
                ]))
            }
            
        } else if let viewModel = pokemonListViewModel {
            let pokemonListSection = PokemonListSection.pokemonList.rawValue
            var loadRows = [IndexPath]()
            let fromIndex = viewModel.limitFetch * (viewModel.fetchTimes - 1)
            let toIndex = viewModel.limitFetch * viewModel.fetchTimes - 1
            
            for index in fromIndex...toIndex {
                loadRows.append(IndexPath(row: index, section: pokemonListSection))
            }
            
            DispatchQueue.main.async {
                self.pokemonListCollectionView.insertItems(at: loadRows)
                self.pokemonListCollectionView.reloadSections(IndexSet(integer: PokemonListSection.loader.rawValue))
            }
        }
    }
    
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.pokemonListCollectionView.reloadSections(
                IndexSet(integer: PokemonListSection.loader.rawValue)
            )
        }
    }
    
    func hideErrorView() {
        DispatchQueue.main.async {
            self.pokemonListCollectionView.reloadSections(
                IndexSet(integer: PokemonListSection.error.rawValue)
            )
        }
    }
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = self.view.safeAreaLayoutGuide.layoutFrame.width - spacing * 2
        
        switch PokemonListSection(rawValue: indexPath.section) {
        case .pokemonList:
            let availableViewWidth = viewWidth - spacing
            
            let itemWidth: CGFloat
            if availableViewWidth / 2 > 200 { itemWidth = 200 }
            else { itemWidth = availableViewWidth / 2 }
            
            return CGSize(width: itemWidth, height: 220)
            
        case .loader:
            return pokemonListViewModel?.isLoading == true ?
            CGSize(width: viewWidth, height: 80) :
                .zero
            
        case .error:
            return pokemonListViewModel?.errorMessage != nil ?
            CGSize(width: viewWidth, height: 200) :
                .zero
            
        case .none:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}

extension PokemonListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch PokemonListSection(rawValue: section) {
        case .pokemonList:
            guard let pokemonsCount = pokemonListViewModel?.currentCount,
                  pokemonsCount > 0
            else { return 0 }
            return pokemonsCount + 1
            
        case .loader, .error:
            return 1
            
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch PokemonListSection(rawValue: indexPath.section) {
        case .pokemonList:
            guard let pokemon: PokemonModel = pokemonListViewModel?.pokemons?.result[indexPath.row],
                  let pokemonCell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell
            else { return UICollectionViewCell() }
            
            pokemonCell.setupCell(with: pokemon)
            
            return pokemonCell
            
            
        case .loader:
            guard let loaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: LoaderCollectionViewCell.identifier, for: indexPath) as? LoaderCollectionViewCell
            else { return UICollectionViewCell() }

            if pokemonListViewModel?.isLoading == true {
                loaderCell.setupCell()
            } else {
                loaderCell.removeFromSuperview()
            }
            
            return loaderCell
            
            
        case .error:
            guard let errorCell = collectionView.dequeueReusableCell(withReuseIdentifier: ErrorCollectionViewCell.identifier, for: indexPath) as? ErrorCollectionViewCell
            else { return UICollectionViewCell() }

            if let errorMessage = pokemonListViewModel?.errorMessage {
                errorCell.delegate = self
                errorCell.setupCell(errorMessage: errorMessage)
            } else {
                errorCell.removeFromSuperview()
            }
            
            return errorCell
            
            
        case .none:
            return UICollectionViewCell()
        }
    }
    
    @objc func onReloadButtonSelected(_ sender: UIButton) {
        print("selected bangsat")
        pokemonListViewModel?.getPokemonList(reloadError: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let pokemon: PokemonModel = self.pokemonListViewModel?.pokemons?.result[indexPath.row],
           let pokemonDetailVC = storyboard.instantiateViewController(withIdentifier: PokemonDetailViewController.identifier) as? PokemonDetailViewController {
            
            pokemonDetailVC.detailUrl = pokemon.url
            self.navigationController?.pushViewController(pokemonDetailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard pokemonListViewModel?.isLoading == false,
            let currCount = pokemonListViewModel?.currentCount,
              currCount > 0
        else { return }
        
        if indexPath.row == currCount - 1 {
            pokemonListViewModel?.getPokemonList()
        }
    }
}

extension PokemonListViewController: ErrorViewProtocol {
    func onReloadButtonSelected() {
        pokemonListViewModel?.getPokemonList(reloadError: true)
    }
}
