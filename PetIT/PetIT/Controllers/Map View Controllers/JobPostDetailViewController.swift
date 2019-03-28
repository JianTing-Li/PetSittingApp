//
//  PostingDetailViewController.swift
//  PetIT
//
//  Created by Stephanie Ramirez on 3/27/19.
//  Copyright © 2019 Stephanie Ramirez. All rights reserved.
//

import UIKit
import Firebase

class JobPostDetailViewController: UIViewController {

    
    @IBOutlet weak var petOwnerProfileImage: CircularImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var jobDescription: UITextView!
    @IBOutlet weak var petBio: UITextView!
    @IBOutlet weak var jobTimeFrame: UITextField!
    @IBOutlet weak var jobWages: UITextField!
    
    public var userModel: UserModel? {
        didSet {
            DispatchQueue.main.async {
                 self.updateUI()
            }
        }
    }
    public var jobPost: JobPost!
    public var displayName: String?
    public var jobDescrip: String?
    
    private var authservice = AppDelegate.authservice
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateUserImageAndUsername()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUserImageAndUsername()
    }
    
    
    private func updateUI() {
        jobDescription.text = jobPost.jobDescription
        petBio.text = userModel!.petBio
        jobTimeFrame.text = jobPost.timeFrame
        jobWages.text = String(jobPost.wage)
}
    
    private func updateUserImageAndUsername() {
        DBService.fetchUser(userId: jobPost.ownerId) { [weak self] (error, user) in
            if let error = error {
                self?.showAlert(title: "Error getting username", message: error.localizedDescription)
            } else if let user = user {
                self?.userModel = user
                self?.fullnameLabel.text = user.firstName
                self?.usernameLable.text = "@" + (user.displayName)
                if let imageURL = user.petPhotoURL {
                    self?.petImage.kf.setImage(with: URL(string: imageURL), placeholder: #imageLiteral(resourceName: "placeholder-image.png"))
                }
                if let photoURL = self?.userModel?.photoURL, !photoURL.isEmpty {
                    self?.petOwnerProfileImage.kf.setImage(with: URL(string: photoURL), placeholder: #imageLiteral(resourceName: "create_new"))
                }
            }
        }
    }
    
    @IBAction func bookJobButtonPressed(_ sender: UIButton) {
    }
    
}
