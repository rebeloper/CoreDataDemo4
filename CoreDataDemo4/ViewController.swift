//
//  ViewController.swift
//  CoreDataDemo4
//
//  Created by Alex Nagy on 16/07/2020.
//  Copyright © 2020 Alex Nagy. All rights reserved.
//

import UIKit
import SparkUI
import Layoutless

import CoreData

// MARK: - Protocols

class ViewController: SViewController {
    
    // MARK: - Navigator
    
    // MARK: - Dependencies
    
    var coreDataStack: CoreDataStack!
    
    // MARK: - Delegates
    
    // MARK: - Properties
    
    var cats = [Cat]()
    
    // MARK: - Buckets
    
    // MARK: - Navigation items
    
    lazy var addBarButtonItem = UIBarButtonItem(title: "Add", style: .done) {
        self.addCat()
    }
    
    lazy var filterAndSortBarButtonItem = UIBarButtonItem(title: "Filter & Sort", style: .done) {
        
        let filterHungry = UIAlertAction(title: "Filter hungry", style: .default) { (action) in
            
        }
        
        let filterYoung = UIAlertAction(title: "Filter young", style: .default) { (action) in
            
        }
        
        let filterOld = UIAlertAction(title: "Filter young", style: .default) { (action) in
            
        }
        
        let filterCutenessAction1 = UIAlertAction(title: "Filter 😻", style: .default) { (action) in
            
        }
        
        let filterCutenessAction2 = UIAlertAction(title: "Filter 😻😻", style: .default) { (action) in
            
        }
        
        let filterCutenessAction3 = UIAlertAction(title: "Filter 😻😻😻", style: .default) { (action) in
            
        }
        
        let sortAZAction = UIAlertAction(title: "Sort by name (A-Z)", style: .default) { (action) in
            
        }
        
        let sortZAAction = UIAlertAction(title: "Sort by name (Z-A)", style: .default) { (action) in
            
        }
        
        Alert.show(.actionSheet, title: "Filter & Sort", message: nil, actions: [filterHungry, filterYoung, filterOld, filterCutenessAction1, filterCutenessAction2, filterCutenessAction3, sortAZAction, sortZAAction, Alert.cancelAction()], completion: nil)
    }
    
    // MARK: - Views
    
    lazy var flowLayout = FlowLayout()
        .item(width: self.view.frame.width, height: 60)
    lazy var collectionView = CollectionView(with: flowLayout, delegateAndDataSource: self)
        .registerCell(CatCell.self, forCellWithReuseIdentifier: CatCell.reuseIdentifier)
    
    // MARK: - init - deinit
    
    // MARK: - Lifecycle
    
    override func preLoad() {
        super.preLoad()
    }
    
    override func onLoad() {
        super.onLoad()
        fetchCats()
    }
    
    override func onAppear() {
        super.onAppear()
    }
    
    override func onDisappear() {
        super.onDisappear()
    }
    
    // MARK: - Configure
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        
        title = "Catz"
        navigationItem.setLeftBarButton(addBarButtonItem, animated: false)
        navigationItem.setRightBarButton(filterAndSortBarButtonItem, animated: false)
    }
    
    override func configureViews() {
        super.configureViews()
    }
    
    // MARK: - Layout
    
    override func layoutViews() {
        super.layoutViews()
        
        stack(.vertical)(
            collectionView
        ).fillingParent().layout(in: container)
    }
    
    // MARK: - Interaction
    
    override func addActions() {
        super.addActions()
    }
    
    override func subscribe() {
        super.subscribe()
    }
    
    // MARK: - internal
    
    // MARK: - private
    
    // MARK: - fileprivate
    
    // MARK: - public
    
    // MARK: - open
    
    // MARK: - @objc Selectors
    
}

// MARK: - Delegates

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - Datasources

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCell.reuseIdentifier, for: indexPath) as! CatCell
        cell.setup(with: cats[indexPath.row], at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - Extensions

extension ViewController {
    
    func addCat() {
        let images = ["cat0", "cat1", "cat2", "cat3", "cat4", "cat5", "cat6", "cat7", "cat8", "cat9"]
        let names = ["Oliver", "Leo", "Milo", "Charlie", "Max", "Jack", "Simba", "Loki", "Oscar", "Jasper"]
        let hungry = [true, false]
        let ages = [1, 2, 3, 4, 5]
        let cutenessLevels = ["😻", "😻😻", "😻😻😻"]
        
        let cat = Cat(context: coreDataStack.managedContext)
        
        cat.imageName = images.randomElement()
        cat.name = names.randomElement()
        cat.isHungry = hungry.randomElement() ?? true
        cat.age = Int64(ages.randomElement() ?? 3)
        cat.cutenessLevel = cutenessLevels.randomElement()
        
        coreDataStack.saveContext { (result) in
            switch result {
            case .success(let finished):
                if finished {
                    self.fetchCats()
                } else {
                    Alert.showErrorSomethingWentWrong()
                }
            case .failure(let err):
                Alert.showError(message: err.localizedDescription)
            }
        }
        
    }
    
    func fetchCats() {
        let catFetch: NSFetchRequest<Cat> = Cat.fetchRequest()
        
        do {
            let cats = try coreDataStack.managedContext.fetch(catFetch)
            self.cats = cats
            self.collectionView.reloadDataOnMainThread()
        } catch {
            Alert.showError(message: error.localizedDescription)
        }
    }
}
