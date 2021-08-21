//
//  MessagesViewController.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

open class MessagesViewController<ViewModel>: UIViewController where ViewModel: MessagesViewModelProtocol {
    
    public typealias Section = ViewModel.Section
    public typealias Item = Section.DiffableItem
    public typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    public struct Constants {
        let defaultInset = CGFloat(8)
    }
    
    public private(set) lazy var collectionView = makeCollectionView()
    public private(set) lazy var dataSource = makeCollectionViewDataSource()
    
    open var constants = Constants()
    open var viewModel: ViewModel!
    
    private let disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupAppearance()
        setupBindings()
    }
    
    // MARK: - Subviews
    
    open func setupSubviews() {
        view.addSubview(collectionView)
                
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Appearance
    
    open func setupAppearance() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = .init(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    // MARK: - Bindings
    
    open func setupBindings() {
        
        viewModel.sections
            .bind(to: dataSource.rx.applySnapshot())
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private
    
    private func makeCollectionViewDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                let identifier: String
                if indexPath.item % 2 == 0 {
                    identifier = OutgoingMessageCollectionViewCell.reuseIdentifier
                } else {
                    identifier = IncomingMessageCollectionViewCell.reuseIdentifier
                }
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                              for: indexPath)
                
                return cell
            }
        )
        
        return dataSource
    }
    
    private func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayouts())
        collectionView.register(IncomingMessageCollectionViewCell.self,
                                forCellWithReuseIdentifier: IncomingMessageCollectionViewCell.reuseIdentifier)
        collectionView.register(OutgoingMessageCollectionViewCell.self,
                                forCellWithReuseIdentifier: OutgoingMessageCollectionViewCell.reuseIdentifier)
        return collectionView
    }
    
    private func makeCollectionViewLayouts() -> UICollectionViewLayout {
        let sectionProvider = { [weak self] (sectionIndex: Int,
                                             layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return self?.makePlainSection(for: sectionIndex, layoutEnvironment: layoutEnvironment)
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider,
                                                         configuration: config)
        
        return layout
    }
    
    private func makePlainSection(for sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemHeights = calculateItemHeights(for: sectionIndex)
        let groupHeight = max(itemHeights.map { $0 + 8 }.reduce(0, +), 1)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(groupHeight))
        
        let customGroup = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { environment in
            return itemHeights.enumerated().map { index, height in
                let containerWidth = environment.container.effectiveContentSize.width
                let yOffset = itemHeights[..<index]
                    .map { $0 + 8 }
                    .reduce(0, +)
                
                let frame = CGRect(origin: CGPoint(x: 0, y: yOffset),
                                   size: CGSize(width: containerWidth, height: height))
                
                return NSCollectionLayoutGroupCustomItem(frame: frame)
            }
        }
        
        let section = NSCollectionLayoutSection(group: customGroup)
        
        section.visibleItemsInvalidationHandler = { [weak self] visibleItems, offset, environment in
            self?.updateCollectionViewTopInset()
        }
        
        return section
    }
    
    private func calculateItemHeights(for sectionIndex: Int) -> [CGFloat] {
//        guard let section = dataSource.snapshot().sectionIdentifiers[safe: sectionIndex] else { return [] }
        
        return dataSource.snapshot().itemIdentifiers.map { _ in 35 }
    }
    
    private func updateCollectionViewTopInset() {
        let contentHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
        let collectionHeight = collectionView.frame.height
            - collectionView.safeAreaInsets.top
            - collectionView.safeAreaInsets.bottom
            - constants.defaultInset
        
        let diff = collectionHeight - contentHeight
        
        collectionView.contentInset.top = diff > 0 ? diff + constants.defaultInset : constants.defaultInset
    }
    
}
