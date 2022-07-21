//
//  RecommandCollectionViewController.swift
//  TrendMedia
//
//  Created by sae hun chung on 2022/07/20.
//

import UIKit
import Toast
import Kingfisher

/*
 TabelView -> CollectionView
 
 Row -> Item
 
 heightForRawAt -> FlowLayout (heightForRawAt이 없는 이유)
 */

class RecommandCollectionViewController: UICollectionViewController {

    static let identifier = "RecommandCollectionViewController"
    
    var imageURL = "https://upload.wikimedia.org/wikipedia/commons/7/72/Alcedo_azurea_-_Julatten.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 컬렉션 뷰의 셀 크기, 셀 사이 간격 등 설정
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 8
        let width = (UIScreen.main.bounds.width - (spacing * 4)) / 3 // 디바이스의 너비 / 3
        
        layout.itemSize = CGSize(width: width, height: width * 1.2) // cell의 size
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing) // 사이 여백
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout // 설정한 layout 적용
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommandCollectionViewCell.identifier, for: indexPath) as? RecommandCollectionViewCell else { return UICollectionViewCell() }
        
        // kingfisher
//        cell.imageView.kf.setImage(with: URL(string: imageURL))
        cell.imageView.backgroundColor = .orange
        
        return cell
    }
    
    // item을 탭하면 처리하는 함수
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        view.makeToast("\(indexPath.item)번째를 선택했습니다.", duration: 1, position: .center)

        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
