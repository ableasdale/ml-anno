xquery version "1.0-ml";

import module namespace common = "http://www.xmlmachines.com/common" at "lib/common.xqy";


common:build-page("Population", 
element div {


element ul {
for $i in //PopulationDefinitions/Population
return (element li { fn:data($i/@civLevel) },
    element ul {
        element li {"Ascension ratio:", fn:data($i/AscensionCalculation/@ratio), "Stack size: ", fn:data($i/AscensionCalculation/@stacksize)    }
    })

} 
})