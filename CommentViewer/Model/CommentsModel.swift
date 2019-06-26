//
//  CommentsModel.swift
//  CommentViewer
//
//  Created by Gökhan Mandacı on 21.06.2019.
//  Copyright © 2019 Gökhan Mandacı. All rights reserved.
//

import Foundation

// MARK: Properties
let pagingReplies = [
    [
        "creator": "user4",
        "comment": "Reply from user4.",
        "isLiked": true,
        "createDate": "2019-06-17T05:07:32.3644517Z",
        "likeCount": 1,
        "profilePicture": "https://randomuser.me/api/portraits/women/17.jpg"
    ],
    [
        "creator": "user2",
        "comment": "Reply from user2.",
        "isLiked": false,
        "createDate": "2019-06-21T05:07:32.3644517Z",
        "likeCount": 0,
        "profilePicture": "https://randomuser.me/api/portraits/women/57.jpg"
    ],
    [
        "creator": "user2",
        "comment": "Reply from user2.",
        "isLiked": false,
        "createDate": "2019-06-14T05:07:32.3644517Z",
        "likeCount": 4,
        "profilePicture": "https://randomuser.me/api/portraits/women/57.jpg"
    ],
    [
        "creator": "user5",
        "comment": "Reply from user5.",
        "isLiked": false,
        "createDate": "2019-06-14T06:07:32.3644517Z",
        "likeCount": 8,
        "profilePicture": "https://randomuser.me/api/portraits/men/25.jpg"
    ],
    [
        "creator": "user3",
        "comment": "Reply from user3.",
        "isLiked": true,
        "createDate": "2019-06-17T05:07:32.3644517Z",
        "likeCount": 1,
        "profilePicture": "https://randomuser.me/api/portraits/men/41.jpg"
    ],
    [
        "creator": "user2",
        "comment": "Reply from user2.",
        "isLiked": false,
        "createDate": "2019-06-21T05:07:32.3644517Z",
        "likeCount": 0,
        "profilePicture": "https://randomuser.me/api/portraits/women/57.jpg"
    ],
    [
        "creator": "user4",
        "comment": "Reply from user2.",
        "isLiked": false,
        "createDate": "2019-06-14T05:07:32.3644517Z",
        "likeCount": 4,
        "profilePicture": "https://randomuser.me/api/portraits/women/17.jpg"
    ],
    [
        "creator": "user5",
        "comment": "Reply from user5.",
        "isLiked": false,
        "createDate": "2019-06-14T06:07:32.3644517Z",
        "likeCount": 8,
        "profilePicture": "https://randomuser.me/api/portraits/men/25.jpg"
    ],
    [
        "creator": "user4",
        "comment": "Reply from user3.",
        "isLiked": true,
        "createDate": "2019-06-17T05:07:32.3644517Z",
        "likeCount": 1,
        "profilePicture": "https://randomuser.me/api/portraits/women/17.jpg"
    ],
    [
        "creator": "user2",
        "comment": "Reply from user2.",
        "isLiked": false,
        "createDate": "2019-06-21T05:07:32.3644517Z",
        "likeCount": 0,
        "profilePicture": "https://randomuser.me/api/portraits/women/57.jpg"
    ]
]

let comments: [[String: Any]] = [
    [
        "creator": "user1",
        "comment": "Comment from user1. Comment from user1. Comment from user1. Comment from user1. Comment from user1. Comment from user1. Comment from user1. Comment from user1. Comment from user1. Comment from user1. Comment from user1. Comment from user1.",
        "isLiked": true,
        "createDate": "2019-06-14T05:07:32.3644517Z",
        "likeCount": 5,
        "repliesShown": false,
        "profilePicture": "https://randomuser.me/api/portraits/women/10.jpg",
        "replyCount": 12,
        "actIndActive":false,
        "replies": [
            [
                "creator": "user2",
                "comment": "Reply from user2.",
                "isLiked": false,
                "createDate": "2019-06-14T05:07:32.3644517Z",
                "likeCount": 4,
                "profilePicture": "https://randomuser.me/api/portraits/women/57.jpg"
            ],
            [
                "creator": "user5",
                "comment": "Reply from user5.",
                "isLiked": false,
                "createDate": "2019-06-14T06:07:32.3644517Z",
                "likeCount": 8,
                "profilePicture": "https://randomuser.me/api/portraits/men/25.jpg"
            ]
        ]
    ],
    [
        "creator": "user2",
        "comment": "Comment from user2.",
        "isLiked": false,
        "createDate": "2019-06-14T19:04:56.9042896Z",
        "likeCount": 0,
        "repliesShown": false,
        "profilePicture": "https://randomuser.me/api/portraits/women/57.jpg",
        "replyCount": 0,
        "actIndActive":false,
        "replies": []
    ],
    [
        "creator": "user4",
        "comment": "Comment from user4.",
        "isLiked": true,
        "createDate": "2019-06-15T04:24:49.3656772Z",
        "likeCount": 3,
        "repliesShown": false,
        "profilePicture": "https://randomuser.me/api/portraits/women/17.jpg",
        "replyCount": 1,
        "actIndActive":false,
        "replies": [
            [
                "creator": "user2",
                "comment": "Reply from user2.",
                "isLiked": true,
                "createDate": "2019-06-15T07:24:49.3656772Z",
                "likeCount": 12,
                "profilePicture": "https://randomuser.me/api/portraits/women/57.jpg"
            ]
        ]
    ],
    [
        "creator": "user5",
        "comment": "Comment from user5.",
        "isLiked": false,
        "createDate": "2019-06-14T19:04:56.9042896Z",
        "likeCount": 0,
        "repliesShown": false,
        "profilePicture": "https://randomuser.me/api/portraits/men/91.jpg",
        "replyCount": 0,
        "actIndActive":false,
        "replies": []
    ],
    [
        "creator": "user6",
        "comment": "Comment from user6.",
        "isLiked": false,
        "createDate": "2019-06-14T19:04:56.9042896Z",
        "likeCount": 0,
        "repliesShown": false,
        "profilePicture": "https://randomuser.me/api/portraits/women/11.jpg",
        "replyCount": 2,
        "actIndActive":false,
        "replies": [
            [
                "creator": "user3",
                "comment": "Reply from user3.",
                "isLiked": true,
                "createDate": "2019-06-17T05:07:32.3644517Z",
                "likeCount": 1,
                "profilePicture": "https://randomuser.me/api/portraits/men/41.jpg"
            ],
            [
                "creator": "user2",
                "comment": "Reply from user2.",
                "isLiked": false,
                "createDate": "2019-06-21T05:07:32.3644517Z",
                "likeCount": 0,
                "profilePicture": "https://randomuser.me/api/portraits/women/57.jpg"
            ]
        ]
    ]
]

struct CommentModel {
    var creator: String?
    var comment: String?
    var isLiked: Bool = false
    var creationDate: String?
    var likeCount: Int?
    var repliesShown: Bool = false
    var actIndActive: Bool = false
    var profilePicture: String?
    var replyCount: Int?
    var replies = [ReplyModel]()
    
    init(_ comment: [String: Any]) {
        if let creator = comment["creator"] as? String {
            self.creator = creator
        }
        if let comment = comment["comment"] as? String {
            self.comment = comment
        }
        if let isLiked = comment["isLiked"] as? Bool {
            self.isLiked = isLiked
        }
        if let creationDate = comment["createDate"] as? String {
            self.creationDate = creationDate
        }
        if let likeCount = comment["likeCount"] as? Int {
            self.likeCount = likeCount
        }
        if let repliesShown = comment["repliesShown"] as? Bool {
            self.repliesShown = repliesShown
        }
        if let actIndActive = comment["actIndActive"] as? Bool {
            self.actIndActive = actIndActive
        }
        if let profilePicture = comment["profilePicture"] as? String {
            self.profilePicture = profilePicture
        }
        if let replyCount = comment["replyCount"] as? Int {
            self.replyCount = replyCount
        }
        if let replies = comment["replies"] as? [[String: Any]] {
            for reply in replies {
                let replyObj = ReplyModel(reply)
                self.replies.append(replyObj)
            }
        }
    }
}

struct ReplyModel {
    var creator: String?
    var comment: String?
    var isLiked: Bool = false
    var creationDate: String?
    var likeCount: Int?
    var profilePicture: String?
    
    init(_ reply: [String: Any]) {
        if let creator = reply["creator"] as? String {
            self.creator = creator
        }
        if let comment = reply["comment"] as? String {
            self.comment = comment
        }
        if let isLiked = reply["isLiked"] as? Bool {
            self.isLiked = isLiked
        }
        if let creationDate = reply["createDate"] as? String {
            self.creationDate = creationDate
        }
        if let likeCount = reply["likeCount"] as? Int {
            self.likeCount = likeCount
        }
        if let profilePicture = reply["profilePicture"] as? String {
            self.profilePicture = profilePicture
        }
    }
}
