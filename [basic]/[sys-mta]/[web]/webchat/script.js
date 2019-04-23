function update () {
	setTimeout ( "aktualizuj()", 500 );
	setTimeout ( "update()" , 1500 );
}

function aktualizuj() {
	getAll (
		function ( wiadomosci ) {
			var wiadomosciElement = document.getElementById ( "msg" );
			while ( wiadomosciElement.hasChildNodes() ) {
				wiadomosciElement.removeChild ( wiadomosciElement.firstChild );
			}
			var dlugosc = wiadomosci.length - 1
			
			if ( wiadomosci.length != 0 ) {
				for ( var i = 0; i <= dlugosc; i++ ) {
					
					var row = document.createElement("tr");
					
					var data = wiadomosci[i][0];
					var nick = wiadomosci[i][1].toString().htmlEntities();
					var wiadomosc = wiadomosci[i][2].toString().htmlEntities();
					var kolor = wiadomosci[i][3] + ', ' + wiadomosci[i][4] + ', ' + wiadomosci[i][5];
					var typ = wiadomosci[i][6];
					
					var cell = document.createElement("td");
					cell.className = "czas"
					cell.innerHTML = data;
					row.appendChild ( cell );
					
					var cell2 = document.createElement("td");
					cell2.className = "tryb"
					cell2.innerHTML = typ
					row.appendChild ( cell2 );
					
					var cell3 = document.createElement("td");
					cell3.innerHTML = '<span style="color: rgb('+kolor+'); font-weight: bold;">'+nick+'</span>';
					row.appendChild ( cell3 );
					
					var cell4 = document.createElement("td");
					cell4.innerHTML = wiadomosc;
					row.appendChild ( cell4 );
					
					wiadomosciElement.appendChild ( row )
				}
			}
        }
	);
}

String.prototype.htmlEntities = function () {
   return this.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
};

function sendMsg (e) {
	var keynum;
	var keychar;
	var numcheck;
	
	keynum = e.which;

	if (keynum == 13) {
		send();
	}
};

function send () {
	var input1 = document.getElementById("nickI");
	var input2 = document.getElementById("wiadomoscI");
		
	if ( input1.value == "Nick" ) {
		alert ( "Type a nick!" );
		return 0;
	}
		
	if ( input2.value == "Wiadomosc" ) {
		alert ( "Type your message to send!" );
		return 0;
	}
	
	if ( input1.value != "" && input2.value != "" ) {
		sendMessageToAllPlayers ( input1.value, input2.value, function ( playerCount ) {});
		input2.value = '';
	} else {
		alert ( "Type your message to send!" );
	}
}

function nickB() {
	var nick = document.getElementById('nickI');
	if	(nick.value=='') 
		nick.value='Nick';
};

function nickF() {
	var nick = document.getElementById('nickI'); 
	if	(nick.value=='Nick')
		nick.value='';
};

function wlasciwosciB() {
	var wiadomosc = document.getElementById('wiadomoscI');	
	if	(wiadomosc.value=='') 
		wiadomosc.value='Message';
};

function wlasciwosciF() {
	var wiadomosc = document.getElementById('wiadomoscI');
	if	(wiadomosc.value=='Message')
		wiadomosc.value='';
};
