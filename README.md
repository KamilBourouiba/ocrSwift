# Image Text Extractor

This Swift script utilizes the Vision and CoreImage frameworks to extract text from PNG images and save it to JSON files.

## Usage

1. **Requirements**: Ensure you have the required frameworks installed and configured in your Xcode project.

2. **Integration**: Copy the provided code into your Swift project.

3. **Functionality**: This script provides three functions:
    - `extractText(from:)`: Extracts text from a provided image URL using Vision framework.
    - `saveTextToJson(_:to:)`: Saves extracted text to a JSON file.
    - `processImages(in:)`: Processes PNG images in a specified folder and saves extracted text to corresponding JSON files.

4. **Execution**: Execute the script with the folder containing PNG images you want to process. The extracted text will be saved as JSON files in the same directory.

## Example

```swift
let fileManager = FileManager.default
guard let currentPath = fileManager.currentDirectoryPath as NSString? else {
    print("Failed to locate the current directory.")
    exit(1)
}
let folderURL = URL(fileURLWithPath: currentPath.appendingPathComponent("curiosa_images"))

processImages(in: folderURL)
```

## Dependencies

- **Vision Framework**: Used for text recognition.
- **CoreImage Framework**: Used for handling images.

## License

This script is released under the [MIT License](https://opensource.org/licenses/MIT). Feel free to use, modify, and distribute as per the terms of the license.