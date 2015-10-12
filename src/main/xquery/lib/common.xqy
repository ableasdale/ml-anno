xquery version "1.0-ml";

module namespace common="http://www.xmlmachines.com/common";

declare default function namespace "http://www.w3.org/2005/xpath-functions";
declare namespace xhtml = "http://www.w3.org/1999/xhtml";



declare function common:build-page($sub as xs:string, $html as element(div)){
xdmp:set-response-content-type("text/html; charset=utf-8"),
'<!DOCTYPE html>',
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>    
    <title>MarkLogic Anno Game Settings Tool</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">{" "}</script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/> 
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js">{" "}</script>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.7.0/codemirror.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.7.0/codemirror.min.js">{" "}</script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.7.0/mode/xml/xml.min.js">{" "}</script>
    
    
    <script type="text/javascript"><![CDATA[   
  

jQuery(document).ready(function($) {
            $('.codemirror').each(function(index) {
                $(this).attr('id', 'code-' + index);
                CodeMirror.fromTextArea(document.getElementById('code-' + index), {
                        mode: "xml",
                        height: "350px",
                        lineNumbers: true,
                        tabMode: "indent"
                    }
                );

            });
        });


        $('#overlay').on('show.bs.modal');         
    ]]></script>
  </head>
  <body>
    <div class="container">
    {common:nav($sub)}
    {$html} 
    </div>
  </body>
</html>};

declare function common:generate-filename() as xs:string {
    fn:concat(xdmp:hostname(),"-",fn:format-dateTime(fn:current-dateTime(), "[Y01][M01][D01]-[H01][m01][s01]"),".zip")
};

declare function common:nav-item($sub as xs:string, $items) as element(li)+ {
    for $i in $items 
    let $li := if($i = $sub)
    then (element li {attribute class {"active"}, common:uri($i) })
    else (element li {common:uri($i)})
    return $li
};


declare function common:process-upgrades($upgrade as element(Upgrade)+){
"TODO - UPGRADE"
};



declare function common:process-costs($costs as element(Costs)){
if ($costs/Cost)
then(for $x in $costs/Cost
return element p {fn:data($x/@amount)})
else ("NO COST!")
};

declare function common:uri($str as xs:string) as element(a) {
    if(fn:contains($str," "))
    then(element a {attribute href {fn:concat(fn:substring-before(fn:lower-case($str), " "), ".xqy")},$str})
    else(element a {attribute href {fn:concat(fn:lower-case($str), ".xqy")},$str})
};

declare function common:nav($sub as xs:string) as element(div){
<div class="row">
    <h3>Anno Online Tools <small>{$sub}</small></h3>
    <div class="navbar navbar-default" role="navigation">
        <ul class="nav navbar-nav">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <img style="margin: 0.65em 0.4em 0 0.7em;" src="/assets/images/logo.png"/>
            </div>            
            { common:nav-item($sub, ("Default", "Goods", "Monuments", "Buildings", "Population", "Tech Trees"))}            
            <!--li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Visual Diff <span class="caret"></span></a>
                <ul class="dropdown-menu">                  
                    <li><a href="/visual.xqy?cfg=assignments">Assignments</a></li>
                    <li><a href="/visual.xqy?cfg=clusters">Clusters</a></li>
                    <li><a href="/visual.xqy?cfg=databases">Databases</a></li>
                    <li><a href="/visual.xqy?cfg=groups">Groups</a></li>
                    <li><a href="/visual.xqy?cfg=hosts">Hosts</a></li>
                    <li><a href="/visual.xqy?cfg=server">Server</a></li>
                </ul>
            </li-->   
        </ul>
    </div>
</div>
};

declare function common:form-checkboxes($seq){
    for $x in $seq
    return
    element div {
        attribute class {"checkbox"},
        element label {
            element input {attribute type {"checkbox"}, attribute name {$x}, $x}
        }
    }     
};

declare function common:button(){
    <button data-target="#confirm-delete" data-toggle="modal" type="submit" id="overlay" class="btn btn-default"><span class="glyphicon glyphicon-record">{" "}</span> Update</button>
};

(: TODO - params :)
declare function common:form($action, $data){
    element form { 
        attribute role {"form"}, 
        attribute method {"POST"},
        attribute name {"form"},
        attribute action {$action},
        $data,
        element hr {" "},
        common:button()
    }
};


declare function common:seq-no-contains($string as xs:string, $searchStrings as xs:string*) as xs:boolean {
    not( some $searchString in $searchStrings satisfies ($string eq $searchString) )
};

declare function common:seq-contains($string as xs:string, $searchStrings as xs:string*) as xs:boolean {
    some $searchString in $searchStrings satisfies ($string eq $searchString)
};
