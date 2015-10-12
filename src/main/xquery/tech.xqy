xquery version "1.0-ml";

import module namespace common = "http://www.xmlmachines.com/common" at "lib/common.xqy";


common:build-page("Tech Trees", 
element div {

element ul {
    for $i in //techtrees/techtree
    return (element li {fn:data($i/@name)},
        element ul {
            for $j in $i/leaf
            return element li {fn:data($j/@name)}
        }
    )
    
} 
})