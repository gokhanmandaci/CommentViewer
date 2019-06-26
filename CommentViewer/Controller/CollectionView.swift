//
//  ViewController2.swift
//  CommentViewer
//
//  Created by Gökhan Mandacı on 26.06.2019.
//  Copyright © 2019 Gökhan Mandacı. All rights reserved.
//

import UIKit

class CollectionView: UIViewController {

    // MARK: Parameters
    var commentsArray = [CommentModel]()
    
    // MARK: Outlets
    @IBOutlet weak var clvComments: UICollectionView!
    
    // MARK: Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for comment in comments {
            let commentModel = CommentModel(comment)
            commentsArray.append(commentModel)
        }
        
        clvComments.reloadData()
        
        clvComments.delegate = self
        
        NotificationCenter.default.addObserver(forName: notiDismissCell, object: nil, queue: OperationQueue.main) { (noti) in
            self.dismissAnimatedCell()
        }
        
        self.navigationItem.title = "CollectionView"
    }
    
}

// Class functions
extension CollectionView {
    @objc private func manageReplies(_ sender: UIButton) {
        let sectionIndex = sender.tag
        let sections = IndexSet.init(integer: sectionIndex)
        if !commentsArray[sectionIndex].repliesShown {
            commentsArray[sectionIndex].repliesShown = true
            clvComments.reloadSections(sections)
        } else {
            if commentsArray[sectionIndex].replyCount! <= commentsArray[sectionIndex].replies.count {
                commentsArray[sectionIndex].repliesShown = false
                clvComments.reloadSections(sections)
            } else {
                commentsArray[sectionIndex].actIndActive = true
                clvComments.reloadSections(sections)
                delay(0.5) {
                    self.commentsArray[sectionIndex].actIndActive = false
                    let replyModel1 = ReplyModel(pagingReplies[0])
                    let replyModel2 = ReplyModel(pagingReplies[1])
                    self.commentsArray[sectionIndex].replies.insert(replyModel1, at: 0)
                    self.commentsArray[sectionIndex].replies.insert(replyModel2, at: 0)
                    self.clvComments.reloadSections(sections)
                }
            }
        }
    }
    
    @objc private func manageLikes(_ sender: UIButton) {
        let sectionIndex = sender.tag
        if commentsArray[sectionIndex].isLiked {
            commentsArray[sectionIndex].isLiked = false
            commentsArray[sectionIndex].likeCount! -= 1
        } else {
            commentsArray[sectionIndex].isLiked = true
            commentsArray[sectionIndex].likeCount! += 1
        }
        let sections = IndexSet.init(integer: sectionIndex)
        clvComments.reloadSections(sections)
    }
    
    @objc private func manageReplyLikes(_ sender: CButton) {
        let sectionIndex = sender.tag
        let rowIndex = sender.row
        if commentsArray[sectionIndex].replies[rowIndex].isLiked {
            commentsArray[sectionIndex].replies[rowIndex].isLiked = false
            commentsArray[sectionIndex].replies[rowIndex].likeCount! -= 1
        } else {
            commentsArray[sectionIndex].replies[rowIndex].isLiked = true
            commentsArray[sectionIndex].replies[rowIndex].likeCount! += 1
        }
        let sections = IndexSet.init(integer: sectionIndex)
        clvComments.reloadSections(sections)
    }
    
    private func dismissAnimatedCell() {
        if CellTag.shared.tag != -1 {
            if let cll = self.view.viewWithTag(CellTag.shared.tag) {
                if let cell = cll as? CommentParentClVC {
                    cell.dismissCell()
                }
                if let cell = cll as? CommentChildClVC {
                    cell.dismissCell()
                }
            }
        }
    }
    
    private func size(indexPath: IndexPath, collectionView: UICollectionView, isReply: Bool) -> CGSize {
        if isReply {
            let cell = Bundle.main.loadNibNamed(R.Nibs.commentChildClV, owner: self, options: nil)?.first as! CommentChildClVC
            let item = commentsArray[indexPath.section].replies[indexPath.row - 1]
            cell.setItem(item)
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            let height: CGFloat = 0
            let targetSize = CGSize(width: getWidth(), height: height)
            let size = cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .defaultHigh, verticalFittingPriority: .fittingSizeLevel)
            return size
        } else {
            let cell = Bundle.main.loadNibNamed(R.Nibs.commentParentClV, owner: self, options: nil)?.first as! CommentParentClVC
            let item = commentsArray[indexPath.section]
            cell.setItem(item)
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            let height: CGFloat = 0
            let targetSize = CGSize(width: getWidth(), height: height)
            let size = cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .defaultHigh, verticalFittingPriority: .fittingSizeLevel)
            return size
        }
    }
}

extension CollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return commentsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if commentsArray[section].repliesShown {
            if commentsArray[section].replies.count > 0 {
                return commentsArray[section].replies.count + 1
            } else {
                return 1
            }
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            collectionView.register(UINib(nibName: R.Nibs.commentParentClV, bundle: nil), forCellWithReuseIdentifier: R.Nibs.Identifiers.commentParentReuseIdCV)
            guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: R.Nibs.Identifiers.commentParentReuseIdCV, for: indexPath) as? CommentParentClVC else { return UICollectionViewCell() }
            
            let commentItem = commentsArray[indexPath.section]
            item.setItem(commentItem)
            item.lblComment.sizeToFit()
            item.btnManageReplies.tag = indexPath.section
            item.btnManageReplies.addTarget(self, action: #selector(CollectionView.manageReplies(_:)), for: .touchUpInside)
            item.btnLike.tag = indexPath.section
            item.btnLike.addTarget(self, action: #selector(CollectionView.manageLikes(_:)), for: .touchUpInside)
            
            if item.isMine {
                item.btnDelete.backgroundColor = UIColor.red
                item.btnDelete.setTitle(R.Strings.delete, for: .normal)
            } else {
                item.btnDelete.backgroundColor = UIColor.gray
                item.btnDelete.setTitle(R.Strings.report, for: .normal)
            }
            
            item.vwSeperator.isHidden = false
            if indexPath.section == 0 {
                item.vwSeperator.isHidden = true
            }
            
            return item
        } else {
            collectionView.register(UINib(nibName: R.Nibs.commentChildClV, bundle: nil), forCellWithReuseIdentifier: R.Nibs.Identifiers.commentChildReuseIdCV)
            guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: R.Nibs.Identifiers.commentChildReuseIdCV, for: indexPath) as? CommentChildClVC else { return UICollectionViewCell() }
            
            let commentItem = commentsArray[indexPath.section].replies[indexPath.row - 1]
            item.setItem(commentItem)
            item.lblComment.sizeToFit()
            item.btnLike.tag = indexPath.section
            item.btnLike.row = indexPath.row - 1
            item.btnLike.addTarget(self, action: #selector(CollectionView.manageReplyLikes(_:)), for: .touchUpInside)
            
            if item.isMine {
                item.btnDelete.backgroundColor = UIColor.red
                item.btnDelete.setTitle("Delete", for: .normal)
            } else {
                item.btnDelete.backgroundColor = UIColor.gray
                item.btnDelete.setTitle("Report", for: .normal)
            }
            
            return item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return size(indexPath: indexPath, collectionView: collectionView, isReply: false)
        } else {
            return size(indexPath: indexPath, collectionView: collectionView, isReply: true)
        }
    }
     
}

extension CollectionView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissAnimatedCell()
    }
}
