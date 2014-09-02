# Module Documentation

## Module Data.DOM.Simple.Ajax

### Values

    getAllResponseHeaders :: forall eff. XMLHttpRequest -> Eff (dom :: DOM | eff) String

    getResponseHeader :: forall eff. String -> XMLHttpRequest -> Eff (dom :: DOM | eff) String

    makeXMLHttpRequest :: forall eff. Eff (dom :: DOM | eff) XMLHttpRequest

    open :: forall eff. String -> String -> XMLHttpRequest -> Eff (dom :: DOM | eff) Unit

    openAsync :: forall eff. String -> String -> XMLHttpRequest -> Eff (dom :: DOM | eff) Unit

    overrideMimeType :: forall eff. String -> XMLHttpRequest -> Eff (dom :: DOM | eff) String

    response :: forall obj eff. XMLHttpRequest -> Eff (dom :: DOM | eff) obj

    responseText :: forall eff. XMLHttpRequest -> Eff (dom :: DOM | eff) String

    responseType :: forall eff. XMLHttpRequest -> Eff (dom :: DOM | eff) String

    send :: forall eff. XMLHttpRequest -> Eff (dom :: DOM | eff) Unit

    sendWithPayload :: forall eff a. a -> XMLHttpRequest -> Eff (dom :: DOM | eff) Unit

    setRequestHeader :: forall eff. String -> String -> XMLHttpRequest -> Eff (dom :: DOM | eff) Unit

    setResponseType :: forall eff. String -> XMLHttpRequest -> Eff (dom :: DOM | eff) Unit

    statusText :: forall eff. XMLHttpRequest -> Eff (dom :: DOM | eff) String


## Module Data.DOM.Simple.Document

### Type Classes

    class Document b where
      title :: forall eff. b -> Eff (dom :: DOM | eff) String
      setTitle :: forall eff. String -> b -> Eff (dom :: DOM | eff) Unit
      body :: forall eff. b -> Eff (dom :: DOM | eff) HTMLElement
      setBody :: forall eff. HTMLElement -> b -> Eff (dom :: DOM | eff) Unit


### Type Class Instances

    instance htmlDocument :: Document HTMLDocument

    instance htmlDocumentElement :: Element HTMLDocument

    instance showHtmlDocument :: Show HTMLDocument


## Module Data.DOM.Simple.Element

### Type Classes

    class Element b where
      getElementById :: forall eff. String -> b -> Eff (dom :: DOM | eff) (Maybe HTMLElement)
      getElementsByClassName :: forall eff. String -> b -> Eff (dom :: DOM | eff) [HTMLElement]
      getElementsByName :: forall eff. String -> b -> Eff (dom :: DOM | eff) [HTMLElement]
      querySelector :: forall eff. String -> b -> Eff (dom :: DOM | eff) (Maybe HTMLElement)
      querySelectorAll :: forall eff. String -> b -> Eff (dom :: DOM | eff) [HTMLElement]
      getAttribute :: forall eff. String -> b -> Eff (dom :: DOM | eff) String
      setAttribute :: forall eff. String -> String -> b -> Eff (dom :: DOM | eff) Unit
      hasAttribute :: forall eff. String -> b -> Eff (dom :: DOM | eff) Boolean
      removeAttribute :: forall eff. String -> b -> Eff (dom :: DOM | eff) Unit
      children :: forall eff. b -> Eff (dom :: DOM | eff) [HTMLElement]
      innerHTML :: forall eff. b -> Eff (dom :: DOM | eff) String
      setInnerHTML :: forall eff. String -> b -> Eff (dom :: DOM | eff) Unit
      textContent :: forall eff. b -> Eff (dom :: DOM | eff) String
      setTextContent :: forall eff. String -> b -> Eff (dom :: DOM | eff) Unit
      contentWindow :: forall eff. b -> Eff (dom :: DOM | eff) HTMLWindow
      classRemove :: forall eff. String -> b -> Eff (dom :: DOM | eff) Unit
      classAdd :: forall eff. String -> b -> Eff (dom :: DOM | eff) Unit
      classToggle :: forall eff. String -> b -> Eff (dom :: DOM | eff) Unit
      classContains :: forall eff. String -> b -> Eff (dom :: DOM | eff) Boolean


### Type Class Instances

    instance htmlElement :: Element HTMLElement

    instance showHtmlElement :: Show HTMLElement


### Values

    setAttributes :: forall eff a. (Element a) => [T.Tuple String String] -> a -> Eff (dom :: DOM | eff) Unit


## Module Data.DOM.Simple.Encode

### Values

    decodeURI :: String -> String

    decodeURIComponent :: String -> String

    encodeURI :: String -> String

    encodeURIComponent :: String -> String

    paramatize :: forall a. a -> String

    toJsonString :: forall eff a. a -> Eff (dom :: DOM | eff) String


## Module Data.DOM.Simple.Events

### Types

    data KeyLocation where
      KeyLocationStandard :: KeyLocation
      KeyLocationLeft :: KeyLocation
      KeyLocationRight :: KeyLocation
      KeyLocationNumpad :: KeyLocation

    data KeyboardEventType where
      KeydownEvent :: KeyboardEventType
      KeypressEvent :: KeyboardEventType
      KeyupEvent :: KeyboardEventType

    data MouseEventType where
      MouseMoveEvent :: MouseEventType
      MouseOverEvent :: MouseEventType
      MouseEnterEvent :: MouseEventType
      MouseOutEvent :: MouseEventType
      MouseLeaveEvent :: MouseEventType

    data ProgressEventType where
      ProgressAbortEvent :: ProgressEventType
      ProgressErrorEvent :: ProgressEventType
      ProgressLoadEvent :: ProgressEventType
      ProgressLoadEndEvent :: ProgressEventType
      ProgressLoadStartEvent :: ProgressEventType
      ProgressProgressEvent :: ProgressEventType
      ProgressTimeoutEvent :: ProgressEventType

    data UIEventType where
      UILoadEvent :: UIEventType
      UIUnloadEvent :: UIEventType
      UIAbortEvent :: UIEventType
      UIErrorEvent :: UIEventType
      UISelectEvent :: UIEventType
      UIResizeEvent :: UIEventType
      UIScrollEvent :: UIEventType


### Type Classes

    class Event e where
      eventTarget :: forall eff a. e -> Eff (dom :: DOM | eff) a
      stopPropagation :: forall eff. e -> Eff (dom :: DOM | eff) Unit
      preventDefault :: forall eff. e -> Eff (dom :: DOM | eff) Unit

    class (Event e) <= KeyboardEvent e where
      keyboardEventType :: forall eff. e -> Eff (dom :: DOM | eff) KeyboardEventType
      key :: forall eff. e -> Eff (dom :: DOM | eff) String
      keyCode :: forall eff. e -> Eff (dom :: DOM | eff) Number
      keyLocation :: forall eff. e -> Eff (dom :: DOM | eff) KeyLocation
      altKey :: forall eff. e -> Eff (dom :: DOM | eff) Boolean
      ctrlKey :: forall eff. e -> Eff (dom :: DOM | eff) Boolean
      metaKey :: forall eff. e -> Eff (dom :: DOM | eff) Boolean
      shiftKey :: forall eff. e -> Eff (dom :: DOM | eff) Boolean

    class KeyboardEventTarget b where
      addKeyboardEventListener :: forall e t ta. (KeyboardEvent e) => KeyboardEventType -> (e -> Eff (dom :: DOM | t) Unit) -> b -> Eff (dom :: DOM | ta) Unit
      removeKeyboardEventListener :: forall e t ta. (KeyboardEvent e) => KeyboardEventType -> (e -> Eff (dom :: DOM | t) Unit) -> b -> Eff (dom :: DOM | ta) Unit

    class (Event e) <= MouseEvent e where
      mouseEventType :: forall eff. e -> Eff (dom :: DOM | eff) MouseEventType
      screenX :: forall eff. e -> Eff (dom :: DOM | eff) Number
      screenY :: forall eff. e -> Eff (dom :: DOM | eff) Number

    class MouseEventTarget b where
      addMouseEventListener :: forall e t ta. (MouseEvent e) => MouseEventType -> (e -> Eff (dom :: DOM | t) Unit) -> b -> Eff (dom :: DOM | ta) Unit
      removeMouseEventListener :: forall e t ta. (MouseEvent e) => MouseEventType -> (e -> Eff (dom :: DOM | t) Unit) -> b -> Eff (dom :: DOM | ta) Unit

    class (Event e) <= ProgressEvent e where
      progressEventType :: forall eff. e -> Eff (dom :: DOM | eff) ProgressEventType
      lengthComputable :: forall eff. e -> Eff (dom :: DOM | eff) Boolean
      loaded :: forall eff. e -> Eff (dom :: DOM | eff) Number
      total :: forall eff. e -> Eff (dom :: DOM | eff) Number

    class ProgressEventTarget b where
      addProgressEventListener :: forall e t ta. (ProgressEvent e) => ProgressEventType -> (e -> Eff (dom :: DOM | t) Unit) -> b -> Eff (dom :: DOM | ta) Unit
      removeProgressEventListener :: forall e t ta. (ProgressEvent e) => ProgressEventType -> (e -> Eff (dom :: DOM | t) Unit) -> b -> Eff (dom :: DOM | ta) Unit

    class (Event e) <= UIEvent e where
      uiEventType :: forall eff. e -> Eff (dom :: DOM | eff) UIEventType
      view :: forall eff. e -> Eff (dom :: DOM | eff) HTMLWindow
      detail :: forall eff. e -> Eff (dom :: DOM | eff) Number

    class UIEventTarget b where
      addUIEventListener :: forall e t ta. (UIEvent e) => UIEventType -> (e -> Eff (dom :: DOM | t) Unit) -> b -> Eff (dom :: DOM | ta) Unit
      removeUIEventListener :: forall e t ta. (UIEvent e) => UIEventType -> (e -> Eff (dom :: DOM | t) Unit) -> b -> Eff (dom :: DOM | ta) Unit


### Type Class Instances

    instance eventDOMEvent :: Event DOMEvent

    instance keyboardEventDOMEvent :: KeyboardEvent DOMEvent

    instance keyboardEventTargetHTMLDocument :: KeyboardEventTarget HTMLDocument

    instance keyboardEventTargetHTMLElement :: KeyboardEventTarget HTMLElement

    instance keyboardEventTargetHTMLWindow :: KeyboardEventTarget HTMLWindow

    instance keyboardEventTypeShow :: Show KeyboardEventType

    instance mouseEventDOMEvent :: MouseEvent DOMEvent

    instance mouseEventTargetHTMLDocument :: MouseEventTarget HTMLDocument

    instance mouseEventTargetHTMLElement :: MouseEventTarget HTMLElement

    instance mouseEventTargetHTMLWindow :: MouseEventTarget HTMLWindow

    instance mouseEventTypeShow :: Show MouseEventType

    instance progressEventDOMEvent :: ProgressEvent DOMEvent

    instance progressEventTargetXMLHttpRequest :: ProgressEventTarget XMLHttpRequest

    instance showProgressEventType :: Show ProgressEventType

    instance uiEventDOMEvent :: UIEvent DOMEvent

    instance uiEventTargetHTMLWindow :: UIEventTarget HTMLWindow

    instance uiEventTypeShow :: Show UIEventType


### Values

    toKeyLocation :: Number -> KeyLocation


## Module Data.DOM.Simple.Sugar

### Type Classes

    class DOMArrows b where
      (#<-) :: forall eff. b -> Tuple String String -> Eff (dom :: DOM | eff) Unit
      (<-#) :: forall eff. b -> String -> Eff (dom :: DOM | eff) String
      (<-?) :: forall eff. b -> String -> Eff (dom :: DOM | eff) (Maybe HTMLElement)
      (%<-) :: forall eff. b -> String -> Eff (dom :: DOM | eff) Unit
      (@<-) :: forall eff. b -> String -> Eff (dom :: DOM | eff) Unit


### Type Class Instances

    instance arrowsEffHTMLElement :: (Element a) => DOMArrows (Eff eff a)

    instance arrowsHTMLElement :: (Element a) => DOMArrows a

    instance arrowsMaybeHTMLElement :: (Element a) => DOMArrows (Maybe a)


## Module Data.DOM.Simple.Types

### Types

    data DOM :: !

    data DOMEvent :: *

    data DOMLocation :: *

    data HTMLDocument :: *

    data HTMLElement :: *

    data HTMLWindow :: *

    data JavascriptContext :: *

    data Timeout :: *

    data XMLHttpRequest :: *


## Module Data.DOM.Simple.Unsafe.Document

### Values

    unsafeBody :: forall eff a. a -> Eff (dom :: DOM | eff) HTMLElement

    unsafeSetBody :: forall eff a. HTMLElement -> a -> Eff (dom :: DOM | eff) Unit

    unsafeSetTitle :: forall eff a. String -> a -> Eff (dom :: DOM | eff) Unit

    unsafeTitle :: forall eff a. a -> Eff (dom :: DOM | eff) String


## Module Data.DOM.Simple.Unsafe.Element

### Values

    unsafeChildren :: forall eff a. a -> Eff (dom :: DOM | eff) [HTMLElement]

    unsafeClassAdd :: forall eff a. String -> a -> Eff (dom :: DOM | eff) Unit

    unsafeClassContains :: forall eff a. String -> a -> Eff (dom :: DOM | eff) Boolean

    unsafeClassRemove :: forall eff a. String -> a -> Eff (dom :: DOM | eff) Unit

    unsafeClassToggle :: forall eff a. String -> a -> Eff (dom :: DOM | eff) Unit

    unsafeContentWindow :: forall eff a. a -> Eff (dom :: DOM | eff) HTMLWindow

    unsafeGetAttribute :: forall eff a. String -> a -> Eff (dom :: DOM | eff) String

    unsafeGetElementById :: forall eff a. String -> a -> Eff (dom :: DOM | eff) HTMLElement

    unsafeGetElementsByClassName :: forall eff a. String -> a -> Eff (dom :: DOM | eff) [HTMLElement]

    unsafeGetElementsByName :: forall eff a. String -> a -> Eff (dom :: DOM | eff) [HTMLElement]

    unsafeHasAttribute :: forall eff a. String -> a -> Eff (dom :: DOM | eff) Boolean

    unsafeInnerHTML :: forall eff a. a -> Eff (dom :: DOM | eff) String

    unsafeQuerySelector :: forall eff a. String -> a -> Eff (dom :: DOM | eff) HTMLElement

    unsafeQuerySelectorAll :: forall eff a. String -> a -> Eff (dom :: DOM | eff) [HTMLElement]

    unsafeRemoveAttribute :: forall eff a. String -> a -> Eff (dom :: DOM | eff) Unit

    unsafeSetAttribute :: forall eff a. String -> String -> a -> Eff (dom :: DOM | eff) Unit

    unsafeSetInnerHTML :: forall eff a. String -> a -> Eff (dom :: DOM | eff) Unit

    unsafeSetTextContent :: forall eff a. String -> a -> Eff (dom :: DOM | eff) Unit

    unsafeTextContent :: forall eff a. a -> Eff (dom :: DOM | eff) String


## Module Data.DOM.Simple.Unsafe.Events

### Values

    unsafeAddEventListener :: forall eff t e b. String -> (e -> Eff (dom :: DOM | t) Unit) -> b -> Eff (dom :: DOM | eff) Unit

    unsafeEventKey :: forall eff. DOMEvent -> Eff (dom :: DOM | eff) String

    unsafeEventKeyCode :: forall eff. DOMEvent -> Eff (dom :: DOM | eff) Number

    unsafeEventProp :: forall v eff. String -> DOMEvent -> Eff (dom :: DOM | eff) v

    unsafePreventDefault :: forall eff. DOMEvent -> Eff (dom :: DOM | eff) Unit

    unsafeRemoveEventListener :: forall eff t e b. String -> (e -> Eff (dom :: DOM | t) Unit) -> b -> Eff (dom :: DOM | eff) Unit

    unsafeStopPropagation :: forall eff. DOMEvent -> Eff (dom :: DOM | eff) Unit


## Module Data.DOM.Simple.Unsafe.Sugar

### Values

    dirtyKindDomRecast :: forall eff effn a. (Element a) => Eff eff a -> Eff (dom :: DOM | effn) a


## Module Data.DOM.Simple.Unsafe.Utils

### Values

    ensure :: forall a. a -> Maybe a

    showImpl :: forall a. a -> String


## Module Data.DOM.Simple.Unsafe.Window

### Values

    unsafeClearTimeout :: forall eff b. b -> Timeout -> Eff (dom :: DOM | eff) Unit

    unsafeDocument :: forall eff a. a -> Eff (dom :: DOM | eff) HTMLDocument

    unsafeGetLocation :: forall eff a. a -> Eff (dom :: DOM | eff) String

    unsafeGetSearchLocation :: forall eff a. a -> Eff (dom :: DOM | eff) String

    unsafeInnerHeight :: forall eff b. b -> Eff (dom :: DOM | eff) Number

    unsafeInnerWidth :: forall eff b. b -> Eff (dom :: DOM | eff) Number

    unsafeLocation :: forall eff a. a -> Eff (dom :: DOM | eff) DOMLocation

    unsafeSetInterval :: forall eff b. b -> Number -> Eff eff Unit -> Eff (dom :: DOM | eff) Timeout

    unsafeSetLocation :: forall eff a. String -> a -> Eff (dom :: DOM | eff) Unit

    unsafeSetTimeout :: forall eff b. b -> Number -> Eff eff Unit -> Eff (dom :: DOM | eff) Timeout


## Module Data.DOM.Simple.Window

### Type Classes

    class Location b where
      getLocation :: forall eff. b -> Eff (dom :: DOM | eff) String
      setLocation :: forall eff. String -> b -> Eff (dom :: DOM | eff) Unit
      search :: forall eff. b -> Eff (dom :: DOM | eff) String

    class Window b where
      document :: forall eff. b -> Eff (dom :: DOM | eff) HTMLDocument
      location :: forall eff. b -> Eff (dom :: DOM | eff) DOMLocation
      setTimeout :: forall eff. b -> Number -> Eff eff Unit -> Eff (dom :: DOM | eff) Timeout
      setInterval :: forall eff. b -> Number -> Eff eff Unit -> Eff (dom :: DOM | eff) Timeout
      clearTimeout :: forall eff. b -> Timeout -> Eff (dom :: DOM | eff) Unit
      innerWidth :: forall eff. b -> Eff (dom :: DOM | eff) Number
      innerHeight :: forall eff. b -> Eff (dom :: DOM | eff) Number


### Type Class Instances

    instance domLocation :: Location DOMLocation

    instance htmlWindow :: Window HTMLWindow


### Values

    getLocationValue :: String -> String -> Maybe String

    globalWindow :: HTMLWindow