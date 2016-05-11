function init(){
    var MIN_TIME = 7;
    var MAX_TIME = 19;

    var elements = document.querySelectorAll('tr > td');
    var nowDate = new Date();
    var year = nowDate.getFullYear();
    var month = nowDate.getMonth()+1;
    var day = nowDate.getDate();
    var hour=MIN_TIME;
    var minutes;
    var nowDateEpoch;

    for(var i in elements){
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
    }
    return 0;
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
                row.cells.item(x).style.backgroundColor = "transparent";// 未選択状態の色
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
