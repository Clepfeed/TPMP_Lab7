
# Ответы на контрольные вопросы по Swift и Objective-C

## 1) Как нарисовать контур?
```swift
let path = UIBezierPath()
path.move(to: CGPoint(x: 10, y: 10))
path.addLine(to: CGPoint(x: 100, y: 100))
UIColor.black.setStroke()
path.stroke()
```

## 2) Как нарисовать прямоугольник?
```swift
let rect = CGRect(x: 20, y: 20, width: 100, height: 50)
let path = UIBezierPath(rect: rect)
UIColor.black.setStroke()
path.stroke()
```

## 3) Как заполнить контур цветом? Градиентом?
**Цветом:**
```swift
UIColor.red.setFill()
path.fill()
```

**Градиентом:**
```swift
let context = UIGraphicsGetCurrentContext()
let colors = [UIColor.red.cgColor, UIColor.blue.cgColor] as CFArray
let colorSpace = CGColorSpaceCreateDeviceRGB()
let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)!
context?.saveGState()
path.addClip()
context?.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 100, y: 100), options: [])
context?.restoreGState()
```

## 4) Как заполнить прямоугольник цветом, сохранив цвет контура?
```swift
let rect = CGRect(x: 20, y: 20, width: 100, height: 50)
let path = UIBezierPath(rect: rect)
UIColor.red.setFill()
path.fill()
UIColor.black.setStroke()
path.stroke()
```

## 5) Как нарисовать круг / эллипс?
```swift
let ovalPath = UIBezierPath(ovalIn: CGRect(x: 20, y: 20, width: 100, height: 100))
UIColor.green.setFill()
ovalPath.fill()
```

## 6) Как добавить тень к рисункам?
```swift
let context = UIGraphicsGetCurrentContext()
context?.setShadow(offset: CGSize(width: 5, height: 5), blur: 5, color: UIColor.black.cgColor)
```

## 7) Как нарисовать изображение на контроллере View в прямоугольнике?
```swift
let image = UIImage(named: "example.png")
image?.draw(in: CGRect(x: 10, y: 10, width: 100, height: 100))
```

## 8) Как перерисовать представление View с помощью метода `setNeedsDisplay`?
```swift
view.setNeedsDisplay()
```

## 9) Как вычесть одну фигуру из другой?
```swift
let path1 = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
let path2 = UIBezierPath(ovalIn: CGRect(x: 25, y: 25, width: 50, height: 50))

let combinedPath = CGMutablePath()
combinedPath.addPath(path1.cgPath)
combinedPath.addPath(path2.cgPath)

let context = UIGraphicsGetCurrentContext()
context?.addPath(combinedPath)
context?.eoFillPath() // Использование even-odd fill rule
```

## 10) Какой компонент Cocoa отвечает за обработку жестов?
```
UIGestureRecognizer
```

## 11) Как добавить и обработать жест касания (нажатия) (tap gesture)?
```swift
let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
view.addGestureRecognizer(tap)

@objc func handleTap(_ sender: UITapGestureRecognizer) {
    print("Tapped")
}
```

## 12) Как добавить и обработать долгое нажатие (long press gesture)?
```swift
let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
view.addGestureRecognizer(longPress)

@objc func handleLongPress(_ sender: UILongPressGestureRecognizer) {
    if sender.state == .began {
        print("Long pressed")
    }
}
```

## 13) Как добавить и обработать жест перелистывания (смахивания) (swipe gesture)?
```swift
let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
swipe.direction = .left
view.addGestureRecognizer(swipe)

@objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
    print("Swiped left")
}
```

## 14) Как обрабатывается жест стягивания (щипка) (pinch gesture)?
```swift
let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
view.addGestureRecognizer(pinch)

@objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
    print("Scale: \(sender.scale)")
}
```

## 15) Как обрабатывается жест растягивания (spread gesture)?
```
Жест растягивания обрабатывается также, как и щипок (pinch), с тем отличием, что scale > 1 означает растягивание.
```

## 16) Как добавить жесты непосредственно на Storyboard?
```
1. Перетащить Gesture Recognizer из библиотеки объектов на нужный View.
2. Подключить `@IBAction` к ViewController с помощью Interface Builder.
```

## 17) Какие примитивы рисования Вы знаете?
```
- Линии
- Прямоугольники
- Круги / Эллипсы
- Дуги
- Кривые Безье
- Текст
- Изображения
```

## 18) Что такое CGContext?
```
CGContext — это контекст графики Core Graphics, с помощью которого можно рисовать примитивы, изображения, текст и применять эффекты (например, тени, трансформации).
```

## 19) Что такое UIBezierPath? Чем отличается от CGContext?
```
UIBezierPath — это высокоуровневая оболочка над CGPath, удобная для создания и рендеринга кривых и фигур.

Отличие:
- UIBezierPath проще в использовании и поддерживает методы fill и stroke.
- CGContext — низкоуровневый API для полного контроля над рендерингом.
```

## 20) Что такое CGImage?
```
CGImage — это низкоуровневое представление изображения в Core Graphics (растровое изображение).
```

## 21) Что такое CGPath?
```
CGPath — это набор графических примитивов (линий, дуг и т.п.), используемый Core Graphics для описания форм.
```

## 22) В чем заключаются трудности использования двумерной графики?
```
- Низкоуровневая работа с CGContext требует точного управления состоянием.
- Трудно реализовывать сложные трансформации и клиппинг.
- Проблемы с производительностью при большом количестве отрисовок.
- Трудности с поддержкой Retina-разрешения и масштабированием.
```
