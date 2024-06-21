# FormField
A wrapper component which support UIControl components with label and helper message (Success/Info/Error management).

![Figma anatomy](https://github.com/adevinta/spark-ios-component-form-field/blob/main/.github/assets/anatomy.png)

## Specifications
The formfield specifications on Zeroheight is [here](https://spark.adevinta.com/1186e1705/p/590121-components).

## Usage
FormField is available on UIKit and SwiftUI.

### FormFieldUIView
Parameters:
* `theme`: The current Spark-Theme. [You can always define your own theme.](https://github.com/adevinta/spark-ios/wiki/Theming#your-own-theming)
* `component`: The component (UIControl) is covered by formfield.
* `feedbackState`: The formfield feedback state. 'Default' or 'Error'.(There aren't design changes for Success and Info states. They will be managed with 'Default')
* `title`: An option string. The title is rendered above the component.
* `attributedTitle`: An option attributed string to change label of font or size.
* `description`: An option string. The title is rendered under the component.
* `attributedDescription`: An option attributed string to change helper message of font or size.
* `isTitleRequired`: A bool value to add asterisk character at the end of title for specifying required field.
* `isEnabled`: A bool value to change wrapped component enabled state
* `isSelected`: A bool value to change wrapped component selected state

### FormFieldView
Parameters:
* `theme`: The current Spark-Theme. [You can always define your own theme.](https://github.com/adevinta/spark-ios/wiki/Theming#your-own-theming)
* `component`: The component (UIControl) is covered by formfield.
* `feedbackState`: The formfield feedback state. 'Default' or 'Error'.(There aren't design changes for Success and Info states. They will be managed with 'Default')
* `title`: An option string. The title is rendered above the component.
* `attributedTitle`: An option attributed string to change label of font or size.
* `description`: An option string. The title is rendered under the component.
* `attributedDescription`: An option attributed string to change helper message of font or size.
* `isTitleRequired`: A bool value to add asterisk character at the end of title for specifying required field.

## Examples
### FormFieldUIView

```swift
let component: UIControl = CheckboxUIView(
   theme: SparkTheme.shared,
   text: "Hello World",
   checkedImage: DemoIconography.shared.checkmark.uiImage,
   selectionState: .unselected,
   alignment: .left
)

let formfield = FormFieldUIView(
   theme: SparkTheme.shared,
   component: self.component,
   feedbackState: .default,
   title: "Agreement",
   description: "Your agreement is important to us."
)

view.addSubview(formfield)

NSLayoutConstraint.activate([
  formfield.leadingAnchor.constraint(equalTo: view.leadingAnchor),
  formfield.trailingAnchor.constraint(equalTo: view.trailingAnchor),
  formfield.topAnchor.constraint(equalTo: view.topAnchor),
  formfield.bottomAnchor.constraint(equalTo: view.bottomAnchor)
])
```

### FormFieldView
```swift
var component: some View {
   CheckboxView(
      text: "Hello World",
      checkedImage: DemoIconography.shared.checkmark.image,
      theme: SparkTheme.shared,
      intent: .success,
      selectionState: .constant(.selected)
   )
}

var body: some View {
    FormFieldView(
       theme: SparkTheme.shared,
       component: {
          self.component
       },
       feedbackState: .default,
       title: "Agreement",
       description: "Your agreement is important to us.",
       isTitleRequired: false
    )
   .disabled(false)
}
```

## License

```
MIT License

Copyright (c) 2024 Adevinta

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```