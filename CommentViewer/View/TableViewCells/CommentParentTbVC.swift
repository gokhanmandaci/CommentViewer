//
//  CommentParentTbVC.swift
//  CommentViewer
//
//  Created by Gökhan Mandacı on 21.06.2019.
//  Copyright © 2019 Gökhan Mandacı. All rights reserved.
//

import UIKit

class CommentParentTbVC: UITableViewCell {

    // MARK: Parameters
    public var isMine: Bool = false
    
    // MARK: Outlets
    @IBOutlet weak var vwSeperator: UIView!
    @IBOutlet weak var btnUser: DownloaderButton!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var btnLikeCount: UIButton!
    @IBOutlet weak var btnReply: UIButton!
    @IBOutlet weak var lblManageReplies: UILabel!
    @IBOutlet weak var btnManageReplies: UIButton!
    @IBOutlet weak var lblMoreHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    // MARK: Actions
    @IBAction func btnUserAction(_ sender: Any) {
    }
    @IBAction func btnLikesAction(_ sender: Any) {
    }
    @IBAction func btnReplyAction(_ sender: Any) {
    }
    @IBAction func btnManageRepliesAction(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
                        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}

extension CommentParentTbVC {
    func setCell(_ item: CommentModel) {
        if let name = item.creator {
            lblUsername.text = name
            if name == "user4" {
                isMine = true
            } else {
                isMine = false
            }
        }
        if let comment = item.comment {
            lblComment.text = comment
        }
        if item.isLiked {
            btnLike.setImage(#imageLiteral(resourceName: "heartfull"), for: .normal)
        } else {
            btnLike.setImage(#imageLiteral(resourceName: "heartempty"), for: .normal)
        }
        if item.actIndActive {
            lblManageReplies.isHidden = true
            btnManageReplies.isHidden = true
            actInd.startAnimating()
        } else {
            lblManageReplies.isHidden = false
            btnManageReplies.isHidden = false
            actInd.stopAnimating()
        }
        if let likeCount = item.likeCount {
            lblLikeCount.text = "\(likeCount) Likes"
        }
        if let profilePicture = item.profilePicture {
            btnUser.dlBackgroundImage(urlString: profilePicture)
        }
        if let rCount = item.replyCount {
            if rCount > 0 {
                lblMoreHeightConstraint.constant = 32
                if item.repliesShown {
                    if rCount == item.replies.count {
                        lblManageReplies.text = "- Hide Replies"
                    } else {
                        lblManageReplies.text = "- View Previous Replies (\(rCount - item.replies.count))"
                    }
                } else {
                    lblManageReplies.text = "- View Replies (\(rCount))"
                }
            } else {
                lblMoreHeightConstraint.constant = 0
            }
        }
        
        if let createDate = item.creationDate {
            lblTime.text = calculateBackDays(createDate)
        }
        self.layoutIfNeeded()
    }
}
