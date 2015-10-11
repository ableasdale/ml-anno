xquery version "1.0-ml";

import module namespace common = "http://www.xmlmachines.com/common" at "lib/common.xqy";


common:build-page("Goods", 
element div {


element ul {
for $i in //Goods/Good
return element li { fn:data($i/@name) }

} 
})