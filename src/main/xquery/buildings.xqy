xquery version "1.0-ml";

import module namespace common = "http://www.xmlmachines.com/common" at "lib/common.xqy";

(:~
<Building id="16" name="b_w_butchery" ui="workyard" filename="b_w_butchery" type="Workyard" production="MeatProduction" blocking="3x3" unlock="Noblemen1">
				<Upkeep amount="30"/>
				<Costs>
					<Cost type="Coins" amount="625000"/>
					<Cost type="Goods" name="Wood" amount="105"/>
					<Cost type="Goods" name="Stone" amount="185"/>
					<Cost type="Goods" name="Tools" amount="115"/>
					<Cost type="Goods" name="Glass" amount="160"/>
				</Costs>
				<Area name="GoodCollectionArea" radius="15"/>
			</Building>
:)

common:build-page("Buildings", 
element div {
for $i in //Buildings/Building
order by xs:integer($i/@id)
return(
element h4 {fn:data($i/@name) },
element p {"Upkeep: ",fn:data($i/Upkeep/@amount) },

element div { attribute class {"row"},

    element div {attribute class {"col-md-6"},

        element dl { attribute class {"dl-horizontal"},
            element dt {"Id" },
            element dd {fn:data($i/@id) },
            element dt {"Name"},
            element dd {fn:data($i/@name) },
            element dt {"UI" },
            element dd {fn:data($i/@ui) },
            element dt {"Filename" },
            element dd {fn:data($i/@filename) },
            element dt {"Type" },
            element dd {fn:data($i/@type) },
            element dt {"Production" },
            element dd {fn:data($i/@production) },    
            element dt {"Blocking" },
            element dd {fn:data($i/@blocking) },  
            element dt {"Unlock" },
            element dd {fn:data($i/@unlock) }  
        } 
    },
    element div {attribute class {"col-md-6"},
        if($i/Upgrade)
        then(common:process-upgrades($i/Upgrade))
        else(common:process-costs($i/Costs)),
        "*"
        
    }
},
element hr {" "}
)
})