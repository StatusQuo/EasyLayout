# EasyLayout

A small collection of function builders for autolayout in code.

## Example

```swift
    //init views
    let foo = UILabel()
    foo.text = "Hello"
    foo.textAlignment = .center

    let bar = UILabel()
    bar.text = "World"
    bar.textAlignment = .center

    let button = UIButton()
    button.setTitle("GO", for: .normal)

    let buttonContainer = UIView()
    buttonContainer.backgroundColor = .darkGray

    let content = UIStackView()
    content.distribution = .fillEqually
```

### Before

    
  ```swift  
    view.addSubview(content)
    content.addArrangedSubview(foo)
    content.addArrangedSubview(bar)

    view.addSubview(buttonContainer)
    buttonContainer.addSubview(button)

    foo.translatesAutoresizingMaskIntoConstraints = false
    bar.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    buttonContainer.translatesAutoresizingMaskIntoConstraints = false
    content.translatesAutoresizingMaskIntoConstraints = false
    
    let constraints: [NSLayoutConstraint] = [
        content.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
        content.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        content.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        buttonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        buttonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        buttonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        button.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
        button.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: -32),
        button.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 32)
    ]

    NSLayoutConstraint.activate(constraints)

```

### After
```swift
    //add subviews and arragned subviews, deactivates autorresizing mask
    view.add {
        content.arrange {
            foo
            bar
        }
        buttonContainer.add {
            button
        }
    }

    //collects constraints and activates them
    layout {
        content.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        content.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        content.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        buttonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        buttonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        buttonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        button.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor)
        button.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: -32)
        button.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 32)
    }

```

## Install

via SwiftPackageManager
