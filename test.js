
var turn = 0;

function doTurn(x, y, bu) {
  updateState(x, y, bu);
  checkWinner();
  turn += 1
}

function player() {
  if (turn % 2 === 0) {
    return "X"
  } else {
    return "O" 
  }
}

function updateState(x, y, bu) {
  var tmp = player(); 
  bu.html(tmp)
  return tmp 
}

function message(string) {
  autoSave();
  turn = -1
  $('td').text("")
  $("#message").html(string);
}

function autoSave() {

  var td = $("td")
  var tmp = [];
  for (var i = 0, len = td.length; i < len; i++) {
    tmp.push(td[i].textContent)
  }

  $.ajax({
    type: "POST",
    data :JSON.stringify({game: {state: tmp}}),
    url: "games",
    contentType: "application/json"
  });
}


function checkWinner() {
  var td = $("td")
  var tmp = [];
  for (var i = 0, len = td.length; i < len; i++) {
    tmp.push(td[i].textContent)
  }

  var arr = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  for (var i = 0, len = arr.length; i < len; i++) {
    var tmpx = 0
    var tmpo = 0
    for (var x = arr[i].length - 1; x >= 0; x--) {
      if (tmp[arr[i][x]] === "X") {
        tmpx += 1 
      } else if (tmp[arr[i][x]] === "O") {
        tmpo += 1 
      }
    }
    
    if (tmpx === 3) {
      message("Player X Won!") 
      return;
    } else if (tmpo === 3) {
      message("Player O Won!") 
      return;
    } else if (turn === 8) {
      message("Tie game") 
      return;
    }
  }
  return false;
}

function attachListeners() {
  $("td").on("click", function() {
    if ($(this).text() === "") {
      doTurn($(this).attr('data-x'), $(this).attr('data-y'), $(this))
    }
  })
}

$(function () {
  attachListeners()
});
