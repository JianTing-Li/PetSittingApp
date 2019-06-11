//
//  DBService+JobPost.swift
//  PetIT
//
//  Created by Stephanie Ramirez on 3/27/19.
//  Copyright © 2019 Stephanie Ramirez. All rights reserved.
//
import Foundation
import FirebaseFirestore
import Firebase

struct JobPostCollectionKeys {
    static let CollectionKey = "jobPost"
    static let CreatedDateKey = "createdDate"
    static let PostIdKey = "postId"
    static let OwnerIdKey = "ownerId"
    static let SitterIdKey = "sitterId"
    static let ImageURLStringKey = "imageURLString"
    static let JobDescriptionKey = "jobDescription"
    static let TimeFrameKey = "timeFrame"
    static let WageKey = "wage"
    static let PetBioKey = "petBio"
//    static let ZipcodeKey = "zipcode"
    static let LatKey = "lat"
    static let LongKey = "long"
    static let StatusKey = "status"
}

extension DBService {
    static public func postJob(jobPost: JobPost, completion: @escaping (Error?) -> Void)  {
        firestoreDB.collection(JobPostCollectionKeys.CollectionKey)
            .document(jobPost.postId).setData([
                JobPostCollectionKeys.CreatedDateKey        : jobPost.createdDate,
                JobPostCollectionKeys.OwnerIdKey            : jobPost.ownerId,
                JobPostCollectionKeys.JobDescriptionKey     : jobPost.jobDescription,
                JobPostCollectionKeys.ImageURLStringKey     : jobPost.imageURLString,
                JobPostCollectionKeys.PostIdKey             : jobPost.postId,
                JobPostCollectionKeys.SitterIdKey           : jobPost.sitterId,
                JobPostCollectionKeys.TimeFrameKey          : jobPost.timeFrame,
                JobPostCollectionKeys.WageKey               : jobPost.wage,
                JobPostCollectionKeys.PetBioKey             : jobPost.petBio,
                JobPostCollectionKeys.LatKey                : jobPost.lat,
                JobPostCollectionKeys.LongKey               : jobPost.long,
                JobPostCollectionKeys.StatusKey             : jobPost.status
                
//                JobPostCollectionKeys.ZipcodeKey            : jobPost.zipcode
                ])
            { (error) in
                if let error = error {
                    print("posting job error: \(error)")
                    completion(error)
                } else {
                    print("job posted successfully to ref: \(jobPost.postId)")
                    completion(nil)
                }
        }
    }
    
    
    static public func deleteJobPost(jobPost: JobPost, completion: @escaping (Error?) -> Void) {
        DBService.firestoreDB
            .collection(JobPostCollectionKeys.CollectionKey)
            .document(jobPost.postId)
            .delete { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
        }
    }

}
