//
//  ChoicePhotoViewController.swift
//  Flooming
//
//  Created by 이범준 on 6/29/22.
//

import UIKit
import Photos
import Mantis

class ChoicePhotoViewController: UIViewController {
    
    
    @IBOutlet weak var choicePhotoView: UIView!
    @IBOutlet weak var choicePhotoImage: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //뷰 모양 조정
        settingBackground(view: choicePhotoView)
        //사진 선택 이미지 모양 조정
        updateImageBorder(image: choicePhotoImage)
        imagePickerController.delegate = self
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        // 5-1) 권한 관련 작업 후 콜백 함수 실행(카메라)
        authDeviceCamera(self) {
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func albumButton(_ sender: UIButton) {
        // 5-2) 권한 관련 작업 후 콜백 함수 실행(사진 라이브러리)
        authPhotoLibrary(self) {
            // .photoLibrary - Deprecated: Use PHPickerViewController instead. (iOS 14 버전 이상 지원)
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        //가고자 하는 VC가 맞는지 확인해줍니다.
        guard let nextVC = destination as? ResultPhotoViewController else {
            return
        }
        
        nextVC.selectedImage = choicePhotoImage.image
    }
}

extension ChoicePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            dismiss(animated: true) {
                self.openCropVC(image: image)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ChoicePhotoViewController: CropViewControllerDelegate {
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation, cropInfo: CropInfo) {
        // 이미지 크롭 후 할 작업 추가
        choicePhotoImage.image = cropped
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    private func openCropVC(image: UIImage) {
        
        let cropViewController = Mantis.cropViewController(image: image)
        cropViewController.delegate = self
        cropViewController.modalPresentationStyle = .fullScreen
        self.present(cropViewController, animated: true)
    }
}
