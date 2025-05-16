# ``SparkFormField``

The Spark FormField provide context to your form elements easily, unifying an a proper way to show a label, required marker, help & status messages or counter in any input/field components. 

## Overview

The component is available on **UIKit** and **SwiftUI** and requires at least **iOS 16**.

### Implementation

- On SwiftUI, you need to use the ``FormFieldView`` View.
- On UIKit, you need to use the ``FormFieldUIView`` UIView.

### Rendering

With a title and helper
![Component rendering.](component.png)

With a counter (only for TextField & TextEditor/TextView) 
![Component rendering.](component_counter.png)

With a clear button 
![Component rendering.](component_clear_button.png)

## A11y

TODO: 

Only the **decrement** and **increment** buttons are accessible. 

The text between the two buttons is not accessible but the **value** of the text *is read by the buttons*.

### Label

#### Default Value

The **decrement** and **increment** buttons *accessibility labels* using **localization** (english and french only).

The default values are :

- Decrement : 
    - English : **Decrement**
    - French : **Décrémenter**

- Increment : 
    - English : **Increment**
    - French : **Incrémenter**

#### Override Value

You can override the decrement and increment accessibilty labels with : 
- UIKit :
    - Decrement : ``SparkUIStepper/customDecrementAccessibilityLabel``
    - Increment : ``SparkUIStepper/customIncrementAccessibilityLabel``

- SwiftUI :
    - Decrement : ``SparkStepper/SparkStepper/decrementAccessibilityLabel(_:)``
    - Increment : ``SparkStepper/SparkStepper/incrementAccessibilityLabel(_:)`` 

---

You can also add some **context** (the name of the stepper for example like *"Number of people"*):
- UIKit : ``SparkUIStepper/contextAccessibilityLabel``
- SwiftUI : ``SparkStepper/SparkStepper/contextAccessibilityLabel(_:)``

Example with a **context** setted to *Number of people* :
- Decrement : 
    - English : **Number of people, Decrement**
    - French : **Nombre de personne, Décrémenter**

- Increment : 
    - English : **Number of people, Increment**
    - French : **Nombre de personne, Incrémenter**

## Resources

- Specification on [ZeroHeight](https://zeroheight.com/1186e1705/p/423a01-form-field)
- Desing on [Figma](https://www.figma.com/design/0QchRdipAVuvVoDfTjLrgQ/Spark-Component-Specs?node-id=44899-1278)
- Discussion on [Slack](https://adevinta.slack.com/archives/C071PA3MWAK)
