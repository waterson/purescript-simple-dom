module Data.DOM.Simple.Events where

import Control.Monad.Eff
import Control.Monad

import Data.DOM.Simple.Types
import Data.DOM.Simple.Window(document, globalWindow)
import Data.DOM.Simple.Ajax
import Data.DOM.Simple.Unsafe.Events

-- XXX Should this be in the Prelude?
class Read s where
  read :: String -> s

{- Generic properties and methods available on all events. -}

class Event e where
  eventTarget     :: forall eff a. e -> (Eff (dom :: DOM | eff) a)
  stopPropagation :: forall eff. e -> (Eff (dom :: DOM | eff) Unit)
  preventDefault  :: forall eff. e -> (Eff (dom :: DOM | eff) Unit)

instance eventDOMEvent :: Event DOMEvent where
  eventTarget     = unsafeEventTarget
  stopPropagation = unsafeStopPropagation
  preventDefault  = unsafePreventDefault

{- Mouse Events -}

data MouseEventType = MouseMoveEvent | MouseOverEvent | MouseEnterEvent
                    | MouseOutEvent | MouseLeaveEvent

instance mouseEventTypeShow :: Show MouseEventType where
  show MouseMoveEvent   = "mousemove"
  show MouseOverEvent   = "mouseover"
  show MouseEnterEvent  = "mouseenter"
  show MouseOutEvent    = "mouseout"
  show MouseLeaveEvent  = "mouseleave"

instance mouseEventTypeRead :: Read MouseEventType where
  read "mousemove"   = MouseMoveEvent
  read "mouseover"   = MouseOverEvent
  read "mouseenter"  = MouseEnterEvent
  read "mouseout"    = MouseOutEvent
  read "mouseleave"  = MouseLeaveEvent

class (Event e) <= MouseEvent e where
  mouseEventType :: forall eff. e -> (Eff (dom :: DOM | eff) MouseEventType)
  screenX :: forall eff. e -> (Eff (dom :: DOM | eff) Number)
  screenY :: forall eff. e -> (Eff (dom :: DOM | eff) Number)

instance mouseEventDOMEvent :: MouseEvent DOMEvent where
  mouseEventType ev = read <$> unsafeEventStringProp "type" ev
  screenX = unsafeEventNumberProp "screenX"
  screenY = unsafeEventNumberProp "screenY"

class MouseEventTarget b where
  addMouseEventListener :: forall e t ta. (MouseEvent e) =>
                           MouseEventType
                               -> (e -> Eff (dom :: DOM | t) Unit)
                               -> b
                               -> (Eff (dom :: DOM | ta) Unit)

  removeMouseEventListener :: forall e t ta. (MouseEvent e) =>
                              MouseEventType
                                  -> (e -> Eff (dom :: DOM | t) Unit)
                                  -> b
                                  -> (Eff (dom :: DOM | ta) Unit)

instance mouseEventTargetHTMLWindow :: MouseEventTarget HTMLWindow where
  addMouseEventListener typ    = unsafeAddEventListener (show typ)
  removeMouseEventListener typ = unsafeRemoveEventListener (show typ)

instance mouseEventTargetHTMLDocument :: MouseEventTarget HTMLDocument where
  addMouseEventListener typ    = unsafeAddEventListener (show typ)
  removeMouseEventListener typ = unsafeRemoveEventListener (show typ)

instance mouseEventTargetHTMLElement :: MouseEventTarget HTMLElement where
  addMouseEventListener typ    = unsafeAddEventListener (show typ)
  removeMouseEventListener typ = unsafeRemoveEventListener (show typ)


{- Keyboard Events -}

data KeyboardEventType = KeydownEvent | KeypressEvent | KeyupEvent

instance keyboardEventTypeShow :: Show KeyboardEventType where
  show KeydownEvent     = "keydown"
  show KeypressEvent    = "keypress"
  show KeyupEvent       = "keyup"

instance keyboardEventTypeRead :: Read KeyboardEventType where
  read "keydown"  = KeydownEvent
  read "keypress" = KeypressEvent
  read "keyup"    = KeyupEvent

-- |Values for the the `keyLocation` of a `KeyboardEvent`
data KeyLocation = KeyLocationStandard | KeyLocationLeft | KeyLocationRight | KeyLocationNumpad

toKeyLocation :: Number -> KeyLocation
toKeyLocation 0 = KeyLocationStandard
toKeyLocation 1 = KeyLocationLeft
toKeyLocation 2 = KeyLocationRight
toKeyLocation 3 = KeyLocationNumpad

class (Event e) <= KeyboardEvent e where
  keyboardEventType :: forall eff. e -> (Eff (dom :: DOM | eff) KeyboardEventType)
  key         :: forall eff. e -> (Eff (dom :: DOM | eff) String)
  keyCode     :: forall eff. e -> (Eff (dom :: DOM | eff) Number)
  keyLocation :: forall eff. e -> (Eff (dom :: DOM | eff) KeyLocation)
  altKey      :: forall eff. e -> (Eff (dom :: DOM | eff) Boolean)
  ctrlKey     :: forall eff. e -> (Eff (dom :: DOM | eff) Boolean)
  metaKey     :: forall eff. e -> (Eff (dom :: DOM | eff) Boolean)
  shiftKey    :: forall eff. e -> (Eff (dom :: DOM | eff) Boolean)

instance keyboardEventDOMEvent :: KeyboardEvent DOMEvent where
  keyboardEventType ev = read <$> unsafeEventStringProp "type" ev
  key                  = unsafeEventKey
  keyCode              = unsafeEventKeyCode
  keyLocation ev       = toKeyLocation <$> unsafeEventNumberProp "keyLocation" ev
  altKey               = unsafeEventBooleanProp "altKey"
  ctrlKey              = unsafeEventBooleanProp "ctrlKey"
  metaKey              = unsafeEventBooleanProp "metaKey"
  shiftKey             = unsafeEventBooleanProp "shiftKey"

class KeyboardEventTarget b where
  addKeyboardEventListener :: forall e t ta. (KeyboardEvent e) =>
                              KeyboardEventType
                                  -> (e -> Eff (dom :: DOM | t) Unit)
                                  -> b
                                  -> (Eff (dom :: DOM | ta) Unit)

  removeKeyboardEventListener :: forall e t ta. (KeyboardEvent e) =>
                                 KeyboardEventType
                                     -> (e -> Eff (dom :: DOM | t) Unit)
                                     -> b
                                     -> (Eff (dom :: DOM | ta) Unit)

instance keyboardEventTargetHTMLWindow :: KeyboardEventTarget HTMLWindow where
  addKeyboardEventListener typ    = unsafeAddEventListener (show typ)
  removeKeyboardEventListener typ = unsafeRemoveEventListener (show typ)

instance keyboardEventTargetHTMLDocument :: KeyboardEventTarget HTMLDocument where
  addKeyboardEventListener typ    = unsafeAddEventListener (show typ)
  removeKeyboardEventListener typ = unsafeRemoveEventListener (show typ)

instance keyboardEventTargetHTMLElement :: KeyboardEventTarget HTMLElement where
  addKeyboardEventListener typ    = unsafeAddEventListener (show typ)
  removeKeyboardEventListener typ = unsafeRemoveEventListener (show typ)

{- UI Events -}

-- XXX this is slightly ham-handed, since
-- <http://www.w3.org/TR/DOM-Level-3-Events/#interface-UIEvent>
-- specifies that only some kinds of elements are valid targets for
-- each of these events.  Might make to refactor more carefully based
-- on what targets can accept what handlers.

data UIEventType = UILoadEvent | UIUnloadEvent | UIAbortEvent
                 | UIErrorEvent | UISelectEvent | UIResizeEvent
                 | UIScrollEvent

instance uiEventTypeShow :: Show UIEventType where
  show UILoadEvent    = "load"
  show UIUnloadEvent  = "unload"
  show UIAbortEvent   = "abort"
  show UIErrorEvent   = "error"
  show UISelectEvent  = "select"
  show UIResizeEvent  = "resize"
  show UIScrollEvent  = "scroll"

instance uiEventTypeRead :: Read UIEventType where
  read "load"     = UILoadEvent
  read "unload"   = UIUnloadEvent
  read "abort"    = UIAbortEvent
  read "error"    = UIErrorEvent
  read "select"   = UISelectEvent
  read "resize"   = UIResizeEvent
  read "scroll"   = UIScrollEvent

class (Event e) <= UIEvent e where
  -- XXX this should really be returning an HTMLAbstractView...
  view   :: forall eff. e -> (Eff (dom :: DOM | eff) HTMLWindow)
  detail :: forall eff. e -> (Eff (dom :: DOM | eff) Number)

instance uiEventDOMEvent :: UIEvent DOMEvent where
  view   = unsafeEventView
  detail = unsafeEventNumberProp "detail"

class UIEventTarget b where
  addUIEventListener :: forall e t ta. (UIEvent e) =>
                        UIEventType
                            -> (e -> Eff (dom :: DOM | t) Unit)
                            -> b
                            -> (Eff (dom :: DOM | ta) Unit)

  removeUIEventListener :: forall e t ta. (UIEvent e) =>
                           UIEventType
                               -> (e -> Eff (dom :: DOM | t) Unit)
                               -> b
                               -> (Eff (dom :: DOM | ta) Unit)

instance uiEventTargetHTMLWindow :: UIEventTarget HTMLWindow where
  addUIEventListener typ    = unsafeAddEventListener (show typ)
  removeUIEventListener typ = unsafeRemoveEventListener (show typ)

{- Progress Events -}

data ProgressEventType = ProgressAbortEvent
                       | ProgressErrorEvent
                       | ProgressLoadEvent
                       | ProgressLoadEndEvent
                       | ProgressLoadStartEvent
                       | ProgressProgressEvent
                       | ProgressTimeoutEvent

instance showProgressEventType :: Show ProgressEventType where
    show ProgressAbortEvent     = "abort"
    show ProgressErrorEvent     = "error"
    show ProgressLoadEvent      = "load"
    show ProgressLoadEndEvent   = "loadend"
    show ProgressLoadStartEvent = "loadstart"
    show ProgressProgressEvent  = "progress"
    show ProgressTimeoutEvent   = "timeout"

instance readProgressEventType :: Read ProgressEventType where
    read "abort"     = ProgressAbortEvent
    read "error"     = ProgressErrorEvent
    read "load"      = ProgressLoadEvent
    read "loadend"   = ProgressLoadEndEvent
    read "loadstart" = ProgressLoadStartEvent
    read "progress"  = ProgressProgressEvent
    read "timeout"   = ProgressTimeoutEvent

class (Event e) <= ProgressEvent e where
    progressEventType :: forall eff. e -> (Eff (dom :: DOM | eff) ProgressEventType)
    lengthComputable  :: forall eff. e -> (Eff (dom :: DOM | eff) Boolean)
    loaded            :: forall eff. e -> (Eff (dom :: DOM | eff) Number)
    total             :: forall eff. e -> (Eff (dom :: DOM | eff) Number)

instance progressEventDOMEvent :: ProgressEvent DOMEvent where
    progressEventType ev = read <$> unsafeEventStringProp "type" ev
    lengthComputable     = unsafeEventBooleanProp "lengthComputable"
    loaded               = unsafeEventNumberProp "loaded"
    total                = unsafeEventNumberProp "total"

class ProgressEventTarget b where
    addProgressEventListener :: forall e t ta. (ProgressEvent e) =>
                                ProgressEventType
                                    -> (e -> Eff (dom :: DOM | t) Unit)
                                    -> b
                                    -> (Eff (dom :: DOM | ta) Unit)

    removeProgressEventListener :: forall e t ta. (ProgressEvent e) =>
                                   ProgressEventType
                                       -> (e -> Eff (dom :: DOM | t) Unit)
                                       -> b
                                       -> (Eff (dom :: DOM | ta) Unit)

instance progressEventTargetXMLHttpRequest :: ProgressEventTarget XMLHttpRequest where
    addProgressEventListener typ    = unsafeAddEventListener (show typ)
    removeProgressEventListener typ = unsafeRemoveEventListener (show typ)

{-
ready :: forall t ta. (Eff (dom :: DOM | t) Unit) -> (Eff (dom :: DOM | ta) Unit)
ready cb = document globalWindow >>= (addEventListener "DOMContentLoaded" $ \_ -> cb)
-}
