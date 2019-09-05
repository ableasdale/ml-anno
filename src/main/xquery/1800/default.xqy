xquery version "1.0-ml";

import module namespace common = "http://www.xmlmachines.com/common" at "lib/common.xqy";
(:
http://en.anno-online.com/en-GB/api/user/login 
:)



common:build-page("XML Files", 
element div {
element ul {
for $i in cts:element-values(xs:QName("Template"))
return element li {element a {attribute href {"/template.xqy?t="||$i},($i)||" ("||cts:frequency($i)||")"}}
}
})

