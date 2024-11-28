<p align="center">
    <img src="Images/01_logo.png" alt="Notes logo" width="300" />
</p>

# Colorama: Sample Project

Colorama is a sample iOS app project complimentary to my articles on the use of diffable data sources in UIKit.

This project showcases the use of diffable data sources with table and collection views alike, as well as implementation of custom views for cells with the help of `UIContentView` type.

## Articles Linked to the Project

Here are the articles for which this sample project was created:

|     |     |
| --- | --- |
| ![Feature image for Tables article](Images/02_grids.png) | [How to Use Diffable Data Source in UIKit](https://dudee.rocks/2024/11/28/how-to-use-diffable-data-source-in-uikit/) |
| ![Feature image for Tables article](Images/02_tables.png) | [How to Use Diffable Data Source with UITableView](https://dudee.rocks/2024/11/28/how-to-use-diffable-data-source-with-uitableview/) |
| ![Feature image for Tables article](Images/02_content.png) | [How to Use UIContentView in UIKit](https://dudee.rocks/2024/11/28/how-to-use-uicontentview-in-uikit/) |
| ![Feature image for Tables article](Images/02_layout.png) | [How to Create Grid Layout in UIKit](https://dudee.rocks/2024/11/28/how-to-create-grid-layout-in-uikit/) |

## UIKit VS SwiftUI

In one of my articles that link to this project I claimed that it’s super easy to create tables and collections that animate dynamic data changes in SwiftUI compared to UIKit. To prove that claim I implemented the core of the sample project in SwiftUI as well. Thus this repository is structured in the following way:

```bash
├── Colorama.xcworkspace
│   └── ColoramaUIKit.xcodeproj
│   └── ColoramaSwiftUI.xcodeproj
```

<p align="left">
    <img src="Images/03_workspace_organization.png" alt="Project structure" width="600" />
</p>

## App Architecture

Both Colorama projects—SwiftUI and UIKit—use largely the same architecture:
- Model manages the creation and storage of the colors represented as ColorItem.
- Views are split into:
    - Table/Collection views;
    - Cell views;
    - Shared details view;
    - Shared helper views (such as, empty state).
- The entry point for both apps is the Root view.

![Colorama Architecture](Images/04_architecture.png)

## Screens and Navigation 

UIKit version of the app is a bit more expansive than the SwiftUI, with the latter implementation only the core of the UIKit version.

![Colorama Architecture](Images/06_navigation.png)

## Use of Extensions

Colorama UIKit relies heavily on extensions to its types to encapsulate different parts of functionality. For example, the list view controller will have its actions and data source methods encapsulated within separate extensions. 

![Colorama Architecture](Images/05_extensions.png)

This is meant to ensure maintainability and ease of navigation within the project.

---

This project was made for the demonstration and education purposes, so feel free to use the code from this project however you want. Let me know if you found this stuff useful/helpful/cool/nice/meh. 😉
 
---
 
<p align="center">
    <img src="Images/07_dudee_logo.png" alt="DUDEE logo" width="200" />
    <p align="center">Made by <a href="https://www.dudee.rocks">DUDEE.rocks</a></p>
</p>


