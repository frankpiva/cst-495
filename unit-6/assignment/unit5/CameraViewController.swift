//
//  CameraViewController.swift
//  unit5
//
//  Created by administrator on 3/1/20.
//  Copyright © 2020 Frank Piva. All rights reserved.
//

import AlamofireImage
import Parse
import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!

    override func viewDidLoad() {
        print("CameraViewController.swift: viewDidLoad()")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapPhotoImageView(_ sender: Any) {
        print("CameraViewController.swift: tapPhotoImageView()")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }

    @IBAction func tapSubmitButton(_ sender: Any) {
        print("CameraViewController.swift: tapSubmitButton()")
        let photoData = self.photoImageView.image!.pngData()
        let fileObject = PFFileObject(name: "image.png", data: photoData!)
        let post = PFObject(className: "Posts")
        post["author"] = PFUser.current()!
        post["caption"] = self.captionTextField.text
        post["image"] = fileObject
        post.saveInBackground { (success, error) in
            if (success) {
                print("CameraViewController.swift: post saved")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("CameraViewController.swift: \(error?.localizedDescription)")
            }
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        self.photoImageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }

}
