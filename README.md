# purescript-simple-dom

### About

A hopefully easy to use library for dealing with the DOM and general javascript APIs.  
Minimal dependencies, and aiming to be as close to the javascript api as possible.  

Very much a WIP, and learning as i go.

Module documentation is available [here](API.md)

### Some Examples

#### Set the contents of an iframe to arbitary html content

```haskell
setContents contents = do
  -- doc = window.document
  doc <- getDocument globalWindow
  -- iframe = doc.querySelector("#siteFrame")
  iframe <- querySelector "#siteFrame" doc
  -- iframeDoc = iframe.contentWindow.document
  iframeDoc <- (contentWindow iframe) >>= getDocument
  -- iframeDoc.querySelector("html").innerHTML = contents
  querySelector "html" iframeDoc >>= setInnerHTML contents

-- or a little shorter
setContents' contents = do
  getDocument globalWindow >>= querySelector "#siteFrame" >>=
    contentWindow >>= getDocument >>= querySelector "html" >>=
      setInnerHTML contents
```



#### Change all a href's on a page and add the original link as a data attribute

```haskell
modifyLinkTarget link = do
  attr <- getAttribute "href" link       -- attr = link.getAttribute("href")
  setAttribute "href" "#" link           -- link.setAttribute("href", "#")
  setAttribute "data-target" attr link   -- link.setAttribute("data-target", attr)
  return link

modifyLinks page = do
  links <- querySelectorAll "a" page      -- links = [HTMLElement]
  sequence $ A.map modifyLinkTarget links -- links.map(modifyLinkTarget)
```

#### Place some content from an API call into a div

```haskell
-- Convert the evt content into text for the callback
handleRequest callback evt =
  target <- eventTarget event
  text <- responseText target
  callback text

-- Construct and perform AJAX request for the specified url
makeGetRequest url callback = do
  req <- makeXMLHttpRequest
  addProgressEventListener ProgressLoadEvent (handleRequest callback) req
  open "get" url req
  setRequestHeader "Content-Type" "application/json" req
  send req

-- retrieve the content and place it inside the div
requestContent = do
  let url = "http://myendpoint.com/"
  doc <- getDocument globalWindow

  makeGetRequest url $ \resp -> do
    querySelector "#myDiv" doc >>= setInnerHtml resp
```
