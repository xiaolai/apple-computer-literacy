
var bind = function (elem, evtName, fn) {
 elem[ addEventListener ? 'addEventListener' : 'attachEvent' ]( addEventListener ? evtName : 'on' + evtName, fn )
}

var navigate = function (ele, evt) {
 var bodyOffset = document.body.getBoundingClientRect ? document.body.getBoundingClientRect().top : 0
 var offset = ele.getBoundingClientRect ? ele.getBoundingClientRect().y - bodyOffset : 0
 window.scrollTo(0, offset - 160)
 ele.classList.add('hlight')
 setTimeout(function () {
  ele.classList.remove('hlight')
 }, 2000)
 evt.preventDefault()
}

var buildTOC = function (contentContainerSelector, tocContainerSelector) {

 var tocContainer = document.querySelector(tocContainerSelector)

 var contentContainer = document.querySelector(contentContainerSelector)
 var childrenEle = Array.prototype.slice.call(contentContainer.children)

 var outlineItems = []

 var getLevel = function (tn) {
  switch (tn) {
   case 'H1': return 1;
   case 'H2': return 2;
   case 'H3': return 3;
   case 'H4': return 4;
   case 'H5': return 5;
   default: return 6
  }
 }

 childrenEle.forEach(function (ele) {
  var tagName = ele.tagName.toUpperCase()
  if (/H[0-9]{1}/.test(tagName)) {
   outlineItems.push({
    tag: tagName,
    level: getLevel(tagName),
    text: ele.innerText,
    element: ele,
   })
  }
 })

 outlineItems.forEach(function (ele) {
  var item = document.createElement('div')
  var itemLabel = document.createElement('div')
  var itemInner = document.createElement('a')
  item.className = 'toc-item'
  itemLabel.className = `toc-item-label level-${ele.level}`
  itemInner.className = 'toc-item-inner'
  itemInner.setAttribute('href', '#')
  itemInner.innerText = ele.text
  bind(itemInner, 'click', function (evt) { return navigate(ele.element, evt) })

  // append to tocContainer
  itemLabel.appendChild(itemInner)
  item.appendChild(itemLabel)

  tocContainer.appendChild(item)
 })
}