import Vision
import CoreImage

func extractText(from image: URL) -> String? {
    guard let cgImage = CIImage(contentsOf: image) else {
        print("Failed to load CIImage from the provided URL.")
        return nil
    }
    
    var extractedText = ""
    
    let request = VNRecognizeTextRequest { request, error in
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        let recognizedStrings = observations.compactMap { observation in
            observation.topCandidates(1).first?.string
        }
        extractedText = recognizedStrings.joined(separator: "\n")
    }
    
    let requestHandler = VNImageRequestHandler(ciImage: cgImage, options: [:])
    do {
        try requestHandler.perform([request])
    } catch {
        print("Error: \(error)")
        return nil
    }
    
    return extractedText
}

func saveTextToJson(_ text: String, to filePath: URL) {
    let jsonData = ["text": text]
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
        try jsonData.write(to: filePath)
        print("Text saved to:", filePath.path)
    } catch {
        print("Error:", error)
    }
}

func processImages(in folderURL: URL) {
    let fileManager = FileManager.default
    do {
        let files = try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
        for file in files {
            if file.pathExtension.lowercased() == "png" {
                if let extractedText = extractText(from: file) {
                    let jsonFileName = file.lastPathComponent.replacingOccurrences(of: ".png", with: ".json")
                    let jsonFilePath = folderURL.appendingPathComponent(jsonFileName)
                    saveTextToJson(extractedText, to: jsonFilePath)
                }
            }
        }
    } catch {
        print("Error:", error)
    }
}

let fileManager = FileManager.default
guard let currentPath = fileManager.currentDirectoryPath as NSString? else {
    print("Failed to locate the current directory.")
    exit(1)
}
let folderURL = URL(fileURLWithPath: currentPath.appendingPathComponent("curiosa_images"))

processImages(in: folderURL)
