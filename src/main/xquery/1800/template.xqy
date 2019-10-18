xquery version "1.0-ml";

import module namespace common = "http://www.xmlmachines.com/common" at "lib/common.xqy";
(:
 <Asset>
                      <Template>VehicleItem</Template>
                      <Values>
                        <Standard>
                          <GUID>191830</GUID>
                          <Name>One-Turn Screw Propeller</Name>
                          <IconFilename>data/ui/2kimages/main/3dicons/machine_items/icon_screw_propeller_2.png</IconFilename>
                          <InfoDescription>19688</InfoDescription>
                        </Standard>
                        <Text>
                          <LocaText>
                            <English>
                              <Text>One-turn Screw Propeller</Text>
                              <Status>Exported</Status>
                              <ExportCount>1</ExportCount>
                            </English>
                          </LocaText>
                          <LineID>26782</LineID>
                        </Text>
                        <Item>
                          <Allocation>SteamShip</Allocation>
                          <MaxStackSize>1</MaxStackSize>
                          <Rarity>Rare</Rarity>
                          <TradePrice>80000</TradePrice>
                        </Item>
                        <Cost/>
                        <VehicleUpgrade>
                          <ForwardSpeedUpgrade>
                            <Value>10</Value>
                            <Percental>1</Percental>
                          </ForwardSpeedUpgrade>
                          <IgnoreWeightFactorUpgrade>
                            <Value>25</Value>
                            <Percental>1</Percental>
                          </IgnoreWeightFactorUpgrade>
                        </VehicleUpgrade>
                        <ExpeditionAttribute>
                          <BaseMorale>0</BaseMorale>
                          <ExpeditionAttributes>
                            <Item>
                              <Attribute>Navigation</Attribute>
                              <Amount>20</Amount>
                            </Item>
                          </ExpeditionAttributes>
                          <ItemDifficulties>Easy;Average;Hard</ItemDifficulties>
                          <FluffText>19688</FluffText>
                        </ExpeditionAttribute>
                        <AttackerUpgrade/>
                        <AttackableUpgrade/>
                        <Locked/>
                        <TradeShipUpgrade/>
                      </Values>
                    </Asset>
:)

declare variable $QUERY := xdmp:get-request-field("t", "VehicleItem");

common:build-page("XML Files", 
element div {
    element table { attribute class {"table table-striped"},
        element thead {
            element tr {
                element th {"GUID"},
                element th {"Name"},
                element th {"Item Type"},
                element th {"Allocation"},
                element th {"Rarity"},
                element th {"Trade Price"},
                element th {"Effect Target"},
                element th {"Culture Attractiveness"}
            }
        },
        element tbody {
            for $i in cts:search(doc(),
                cts:element-range-query(xs:QName("Template"), "=", $QUERY)) 
                (: Todo - tradeprice as index and cts:order? :)
                order by xs:unsignedLong($i/Asset/Values/Item/TradePrice) descending
                return 
                element tr {
                    element td {element a {attribute href {"/asset.xqy?guid="||fn:data($i/Asset/Values/Standard/GUID)}, fn:data($i/Asset/Values/Standard/GUID)}},
                    element td {if(fn:data($i/Asset/Values/Text/LocaText/English/Text)) then (fn:data($i/Asset/Values/Text/LocaText/English/Text)) else (fn:data($i/Asset/Values/Standard/Name))},
                    element td {fn:data($i/Asset/Values/Item/ItemType)},
                    element td {fn:data($i/Asset/Values/Item/Allocation)},
                    element td {fn:data($i/Asset/Values/Item/Rarity)},
                    element td {fn:data($i/Asset/Values/Item/TradePrice)},
                    element td {
                        if (fn:data($i/Asset/Values/ItemEffect/EffectTargets/Item/GUID))  
                        then (
                            for $j in (fn:data($i/Asset/Values/ItemEffect/EffectTargets/Item/GUID))
                                    return (element a {attribute href {"/asset.xqy?guid="||$j}, $j}," ")
                        )    
                        else ()
                    },
                    element td {fn:data($i/Asset/Values/CultureUpgrade/AttractivenessUpgrade/Value)}        
                }
        }
    }
})

