//
//  ViewController.swift
//  CommentViewer
//
//  Created by Gökhan Mandacı on 21.06.2019.
//  Copyright © 2019 Gökhan Mandacı. All rights reserved.
//

import UIKit

class TableView: UIViewController {
    
    // MARK: Parameters
    var commentsArray = [CommentModel]()
    
    // MARK: Outlets
    @IBOutlet weak var tbvComments: UITableView!
    
    // MARK: Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDeviceBounds(Int(self.view.bounds.width), height: Int(self.view.bounds.height))
        
        tbvComments.estimatedRowHeight = 177
        tbvComments.rowHeight = UITableView.automaticDimension
        
        for comment in comments {
            let commentModel = CommentModel(comment)
            commentsArray.append(commentModel)
        }
        
        tbvComments.reloadData()
        
    }
    
}

// Class functions
extension TableView {
    @objc private func manageReplies(_ sender: UIButton) {
        let sectionIndex = sender.tag
        let sections = IndexSet.init(integer: sectionIndex)
        if !commentsArray[sectionIndex].repliesShown {
            commentsArray[sectionIndex].repliesShown = true
            tbvComments.reloadSections(sections, with: .none)
        } else {
            if commentsArray[sectionIndex].replyCount! <= commentsArray[sectionIndex].replies.count {
                commentsArray[sectionIndex].repliesShown = false
                tbvComments.reloadSections(sections, with: .none)
            } else {
                commentsArray[sectionIndex].actIndActive = true
                tbvComments.reloadSections(sections, with: .none)
                delay(0.5) {
                    self.commentsArray[sectionIndex].actIndActive = false
                    let replyModel1 = ReplyModel(pagingReplies[0])
                    let replyModel2 = ReplyModel(pagingReplies[1])
                    self.commentsArray[sectionIndex].replies.insert(replyModel1, at: 0)
                    self.commentsArray[sectionIndex].replies.insert(replyModel2, at: 0)
                    self.tbvComments.reloadSections(sections, with: .none)
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
        tbvComments.reloadSections(sections, with: .none)
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
        tbvComments.reloadSections(sections, with: .none)
    }
}

extension TableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.register(UINib(nibName: R.Nibs.commentParentTbV, bundle: nil), forCellReuseIdentifier: R.Nibs.Identifiers.commentParentReuseId)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.Nibs.Identifiers.commentParentReuseId, for: indexPath) as? CommentParentTbVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            let item = commentsArray[indexPath.section]
            cell.setCell(item)
            cell.lblComment.sizeToFit()
            cell.btnManageReplies.tag = indexPath.section
            cell.btnManageReplies.addTarget(self, action: #selector(TableView.manageReplies(_:)), for: .touchUpInside)
            cell.btnLike.tag = indexPath.section
            cell.btnLike.addTarget(self, action: #selector(TableView.manageLikes(_:)), for: .touchUpInside)
            
            cell.vwSeperator.isHidden = false
            if indexPath.section == 0 {
                cell.vwSeperator.isHidden = true
            }
            
            return cell
        } else {
            tableView.register(UINib(nibName: R.Nibs.commentChildTbV, bundle: nil), forCellReuseIdentifier: R.Nibs.Identifiers.commentChildReuseId)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.Nibs.Identifiers.commentChildReuseId, for: indexPath) as? CommentChildTbVC else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            let item = commentsArray[indexPath.section].replies[indexPath.row - 1]
            cell.setCell(item)
            cell.lblComment.sizeToFit()
            cell.btnLike.tag = indexPath.section
            cell.btnLike.row = indexPath.row - 1
            cell.btnLike.addTarget(self, action: #selector(TableView.manageReplyLikes(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let reportAction = UITableViewRowAction(style: .normal, title: R.Strings.report) { (action, indexPath) in
            tableView.isEditing = false
            print("Report Clicked")
        }
        reportAction.backgroundColor = UIColor.gray
        
        let deleteAction = UITableViewRowAction(style: .default, title: R.Strings.delete) { (action, indexPath) in
            tableView.isEditing = false
            
            if (tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as? CommentParentTbVC) != nil {
                self.commentsArray.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet.init(integer: indexPath.section), with: .automatic)
            } else if (tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as? CommentChildTbVC) != nil {
                self.commentsArray[indexPath.section].replies.remove(at: indexPath.row - 1)
                self.commentsArray[indexPath.section].replyCount! -= 1
                tableView.deleteRows(at: [IndexPath.init(row: indexPath.row, section: indexPath.section)], with: .automatic)
            }
            
        }
        
        if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as? CommentParentTbVC {
            if cell.isMine {
                return [deleteAction]
            } else {
                return [reportAction]
            }
        } else if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as? CommentChildTbVC {
            if cell.isMine {
                return [deleteAction]
            } else {
                return [reportAction]
            }
        } else {
            return []
        }
    }
    
}
