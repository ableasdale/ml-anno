xquery version "1.0-ml";

import module namespace common = "http://www.xmlmachines.com/common" at "lib/common.xqy";

common:build-page("XML Files", 
element div {
for $i at $pos in cts:uris((),(),())
return
(element h3 {$i}, element textarea {attribute class {"codemirror"}, doc($i)} )
})

(: 

element pre {element code {doc($i)} }
<textarea name="editor" id="editor" rows="20" cols="80"> :)