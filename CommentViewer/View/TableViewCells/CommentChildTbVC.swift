//
//  CommentChildTbVC.swift
//  CommentViewer
//
//  Created by Gökhan Mandacı on 21.06.2019.
//  Copyright © 2019 Gökhan Mandacı. All rights reserved.
//

import UIKit

class CommentChildTbVC: UITableViewCell {

    // MARK: Parameters
    public var isMine: Bool = false
    
    // MARK: Outlets
    @IBOutlet weak var btnUser: DownloaderButton!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var btnLike: CButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnLikeCount: UIButton!
    @IBOutlet weak var btnReply: UIButton!
    
    // MARK: Actions
    @IBAction func btnUserAction(_ sender: Any) {
    }
    @IBAction func btnLikesAction(_ sender: Any) {
    }
    @IBAction func btnReplyAction(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension CommentChildTbVC {
    func setCell(_ item: ReplyModel) {
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
        if let likeCount = item.likeCount {
            btnLikeCount.setTitle("\(likeCount) Likes", for: .normal)
        }
        if let createDate = item.creationDate {
            lblTime.text = calculateBackDays(createDate)
        }
        if let profilePicture = item.profilePicture {
            btnUser.dlBackgroundImage(urlString: profilePicture)
        }
    }
}
