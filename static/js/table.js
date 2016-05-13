var nowDate = new Date();
var year = nowDate.getFullYear();
var month = nowDate.getMonth()+1;
var day = nowDate.getDate();

function init(){
    var MIN_TIME = 7;
    var MAX_TIME = 19;
    var elements = document.querySelectorAll('tr > td');
    var hour=MIN_TIME;
    var minutes;
    var nowDateEpoch;

    document.getElementById("request_label_date").innerHTML = year + ":" + month + ":" + day;

    for(var i =0; i < elements.length ; i++){

        if(i%2==0){
            hour +=1;
        }

        minutes = 30 * (i%2);

        if(minutes == 0){
            minutes = minutes + "0";
        }
        nowDateEpoch = new Date(year,month-1,day);
        nowDateEpoch = nowDateEpoch.getTime() / 1000;
        var newID = nowDateEpoch + "_" + hour + "_" + minutes;
        elements[i].id=newID;
        elements[i].style.backgroundColor = "#eeeeee";
    }

    registEvent();
    return 0;
}

function registEvent(){
    var tar_next = document.getElementById("request_date_next");
    var tar_prev = document.getElementById("request_date_prev");
    
    tar_next.addEventListener("click",date_next,false);
    tar_prev.addEventListener("click",date_prev,false);
}

var startCell=null;

function mouseDown(table,e){
    if(!e) var e = window.event;
    startCell = e.srcElement? e.srcElement : e.target;
    if(startCell.tagName !="TD"){
        startCell=null;
        return;
    }
    mouseMove(table,e);
}

function mouseMove(table,e){
    if (!e) var e = window.event;

    var endCell = e.srcElement?e.srcElement:e.target;
    if(!(endCell.tagName=="TD" && startCell))
        return false;

    // セルの位置を取得
    var from = getCellPos(table, startCell);
    var to = getCellPos(table, endCell);
    if(!from || !to)
        return false;

    // 色を変更
    var x, y, cells;
    for(y=0; y<table.rows.length; y++){
        row = table.rows.item(y);
        for(x=0; x<row.cells.length; x++){
            if((from.row-y)*(y-to.row)>=0 && (from.col-x)*(x-to.col)>=0)
                row.cells.item(x).style.backgroundColor = "#ffdddd";// 選択状態の色
            else
                row.cells.item(x).style.backgroundColor = "#eeeeee";// 未選択状態の色
        }
    }
}

// マウスアップのイベント処理
function mouseUp(table, e){
    if (!e) var e = window.event;

    var endCell = e.srcElement?e.srcElement:e.target;
    if(!(endCell.tagName=="TD" && startCell))
        return false;

    // セルの位置を取得
    var from = getCellPos(table, startCell);
    var to = getCellPos(table, endCell);
    if(!from || !to)
        return false;

    // mouseMoveで選択状態表示の更新をさせないようにする
    startCell = null;

}


// tableの中のcellの位置を取得する
function getCellPos(table, cell){
    var pos = new Object();
    if(cell.nodeName == "TD"){
        var x, y, cells;
        for(y=0; y<table.rows.length; y++){
            row = table.rows.item(y);
            for(x=0; x<row.cells.length; x++){
                if(row.cells.item(x) == cell){
                    pos.row = y;
                    pos.col = x;
                    return pos;
                }
            }
        }
    }
    return null;
}
function date_prev(){
    //選択されたセルをDBへ格納
    var elements = document.querySelectorAll('tr > td');
    for(var i =0; i < elements.length ; i++){
       console.log(elements[i].style.backgroundColor); 
    }

    //日付を変更
    day--;
    if(day<1){
        day=31;
        month--;
    }
    if(month<1){
        month=12;
        year--;
    }
    init();
    return 0;
}



function date_next(){
    //選択されたセルをDBへ格納
    var elements = document.querySelectorAll('tr > td');
    for(var i =0; i < elements.length ; i++){
       console.log(elements[i].style.backgroundColor); 
    }

    //日付を変更
    day++;
    if(day>31){
        day=1;
        month++;
    }
    if(month>12){
        month=1;
        year++;
    }
    init();
    return 0;
}

