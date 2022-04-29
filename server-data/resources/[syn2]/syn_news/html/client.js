var data
var book = document.getElementsByClassName("flipbook")[0]
var frontimage = document.getElementById("frontimage")
var midimage = document.getElementById("midimage")
var backimage = document.getElementById("backimage")
var inited = false
var editable = false
var currentEditingPageIndex
var _editor
var settings
var onClose
var bookIsOpen = false
let news
document.getElementById("closesettingsbutton").onclick = function() {
    SetClass("w_settings","off")
}

function StartBook(args) {
    if( args == null ) { return false }
    if( args.data == null ) {return false}
    d = args.data
    edit = !!args.edit
    onClose = args.onClose

    SetClass("w_book","off",false)
    SetClass("w_content","off",false)

    if( !inited ) {
        inited = true
        $('.flipbook').turn({
            width:922*1.5,
            height:600*1.5,
            elevation: 50,
            gradients: true,
            autoCenter: true
        });
    }

    editable = edit
    data = d
    frontimage.value = data.frontImage || ""; frontimage.onchange = function() { data.frontImage = frontimage.value }
    midimage.value = data.midImage || ""; midimage.onchange = function() { data.midimage = midimage.value }
    backimage.value = data.backImage || ""; backimage.onchange = function() { data.backimage = backimage.value }

    if( data == null || data == "" || data.pages == null || data.pages.length == 0 ) {
        $(".flipbook").turn("addPage", CreatePageElement(editable))
        $(".flipbook").turn("addPage", CreatePageElement(editable))
        $(".flipbook").turn("addPage", CreatePageElement(editable))
    } else {
        BuildPages()
        $(".flipbook").turn("page",1);
    }
    $(".flipbook").bind("turned", function(event, page, view) {
        document.getElementsByClassName("w_flip")[0].classList.toggle("off",true)
    });
}

function StopBook() {
    SetClass("w_book","off",true)
    SetClass("w_content","off",true)
}

function BuildPages() {
    var pageCount = $(".flipbook").turn("pages")
    for( var i = pageCount; i > 0; i--) {
        if($(".flipbook").turn("hasPage",i) == false ) { continue}
        $(".flipbook").turn("removePage", i);
    }
    for( var i = 0; i < data.pages.length; i++ ) {
        $(".flipbook").turn("addPage", CreatePageElement(editable,data.pages[i]))
    }
}

function CreatePageElement(editable,data) {
    var element = document.createElement("div")
    element.classList.add("w_bookpage")
    element.id = "bookpage" + ($(".flipbook").turn("pages")+1)
    if( data != null && data.background != null ) {
        element.style.backgroundImage = "url('"+data.background+"')"
    }
    if( data != null && data.backgroundColor != null ) {
        element.style.backgroundColor = data.backgroundColor
    }
    if( data != null && data.color != null ) {
        element.style.color = data.color
    }
    var cont = document.createElement("div")
    cont.id = "pagecontent" + ($(".flipbook").turn("pages")+1)
    cont.classList.add("w_pagecontent")
    cont.setAttribute("pageIndex",$(".flipbook").turn("pages")+1)
    cont.innerHTML = data.content || ""
    element.appendChild(cont)
    return element
}
Array.prototype.insert = function ( index, item ) {
    this.splice( index, 0, item );
};
function SetClass(className,otherClassName,enable) {
    if(document.getElementsByClassName(className).length == 1 ) {
        document.getElementsByClassName(className)[0].classList.toggle(otherClassName,enable)} 
		else 
		{document.getElementById(className).classList.toggle(otherClassName,enable)}
}

function index(page) {
    $(".flipbook").turn("page",page);
}

window.addEventListener('message', function(event) {

    if (event.data.type == "OpenBookGui") {
        if (event.data.value == true) {
			$.post("http://vorp_inventory/NUIFocusOff", JSON.stringify({}));
			isOpen = false;
            news = event.data.newsx
            var url = new URL(window.location.href);
            var pgx = []
            for (const [ind, tab] of Object.entries(news)) {
                pgx.insert(ind, {
                    content:"",
                    background:tab,
                    backgroundColor:"#fff",
                    color:"white",
                });
            }
           /*  for (const [ind, tab] of Object.entries(pgx)) {
                console.log(tab)
            } */
            StartBook({data:{pages:pgx,
    },
    edit: (url.searchParams.get("edit") != null),
	})
        bookIsOpen = true
        } else if (event.data.value === false) {
            if (bookIsOpen) {
                StopBook()
            }
        }
    }
})

$(document).keydown(function(e){
    var previous = 37, next = 39, close = 27, close2 = 8;
    switch (e.keyCode) {
        case previous:
        $('.flipbook').turn('previous');
        break;
        case next:
        $('.flipbook').turn('next');            
        break;
        
        case close:
        Post('http://syn_news/close')
        break;

        case close2:
        Post('http://syn_news/close')
        break;
    }
});



Post = function(url,data) {
    var d = (data ? data : {});
    $.post(url,JSON.stringify(d));
};