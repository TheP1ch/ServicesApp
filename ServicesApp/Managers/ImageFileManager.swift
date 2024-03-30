//
//  FileManager.swift
//  ServicesApp
//
//  Created by Евгений Беляков on 31.03.2024.
//

import UIKit

final class ImageFileManager{
    
    private let folderName = "downloaded_photos"
    
    init(){
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded(){
        guard let url = getFolderURL() else {return}
        
        if !FileManager.default.fileExists(atPath: url.path(percentEncoded: true)){
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            }catch{
                print("Create Folder Error: \(error)")
            }
        }
    }
    
    private func getFolderURL() -> URL? {
        FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appending(path: folderName)
    }
    
    private func getImageUrl(key: String) -> URL? {
        guard let folder = getFolderURL() else {return nil}
        
        return folder.appending(path: key)
    }
    
    func add(key: String, value: UIImage){
        
        guard let data = value.pngData(),
              let url = getImageUrl(key: key) else{
            return
        }
        
        do{
            try data.write(to: url)
        }catch{
            print("Error saving to fileManager: \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard 
            let url = getImageUrl(key: key),
            FileManager.default.fileExists(atPath: url.path())
        else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path())
    }
}
