xquery version "1.0-ml";

import module namespace common = "http://www.xmlmachines.com/common" at "lib/common.xqy";


common:build-page("Monuments", 
element div {


element ul {
for $i in //monuments/monument
return element li { fn:data($i/@name) }

} 
})