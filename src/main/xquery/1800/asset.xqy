xquery version "1.0-ml";

import module namespace common = "http://www.xmlmachines.com/common" at "lib/common.xqy";

declare variable $GUID := xdmp:get-request-field("guid", "VehicleItem");

(: $i/Asset/Values/Standard/GUID :)
common:build-page("XML Files", 
element div {
    element textarea {attribute id {"code-0"}, attribute class {"form-control"}, attribute rows{"35"}, 
    cts:search(doc(), cts:path-range-query("/Asset/Values/Standard/GUID", "=", xs:unsignedLong($GUID)))
    } 
    (:cts:element-value-query(xs:QName("GUID"), $GUID))} :)
})