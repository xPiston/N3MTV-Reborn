let currentspawnable = 0;
let currentvhl = {
	model: '',
	plate: ''
};


let fourriere = {
	title: 'Fourrière',
	subtitle: 'liste',
	limit: 10,
	items: [
		{
			style: 'yellow button',
			key: 'Envoyer à la fourrière',
			action: function(){
				$.post('http://garages/fourriere', JSON.stringify({model: currentvhl.model, plate: currentvhl.plate}));
				store.commit('RETURN_BACK');
				store.commit('RETURN_BACK');
			}
		},
		{ style: 'red button', key: 'Ne rien faire', back: true}
	],
	stats: null,
	slider: null,
	colorPicker: null,
	grid: false,
	style: null,
	onItemChange:null,
	index: 0
};


let vehicles = {
	title: 'Mes véhicules',
	subtitle: 'liste',
	limit: 10,
	items: [
		{ style: 'red button', key: 'Revenir au menu général', back: true}
	],
	stats: null,
	slider: null,
	colorPicker: null,
	grid: false,
	style: null,
	onItemChange:null,
	index: 0
};

let main =  {
	title: 'GARAGES',
	subtitle: 'Actions',
	limit: 10,
	items: [
		{ key: 'Mon garage', action: function(){ store.commit('SET_MENU', vehicles); $.post("http://garages/init", JSON.stringify({spawnable: currentspawnable}))}},
		{ style: 'yellow button', key: 'Rentrer véhicule', action: function(){ $.post("http://garages/store", JSON.stringify({}));}},
		{ style: 'red button', key: 'Fermer', action: function(){$.post('http://garages/close', JSON.stringify({}))}}
	],
	stats: null,
	slider: null,
	colorPicker: null,
	grid: false,
	style: null,
	onItemChange:null,
	index: 0
};


$(document).ready(function(){
	store.commit('SET_MENU', main);
	store.commit('TOGGLE_MENU', false);

	this.message = function (e) {
		let data = e.detail || e.data;
		if (data.openUI === true) {
			store.commit('TOGGLE_MENU', true);

		}
		if (data.spawnable) {
			let row = JSON.parse(data.spawnable);
			currentspawnable = row.spawnable;
		}
		if (data.closeUI === true) {
			store.commit('TOGGLE_MENU', false);
			store.commit('RETURN_BACK');
			store.commit('RETURN_BACK');
		}
		if (data.addlist) {
			let row = JSON.parse(data.addlist);
			let color = row.state == 0 ? 'color:green;' : 'color:orange;';
			let state = row.state == 0 ? 'Rentré' : 'Sortis';

			let action = function() {$.post('http://garages/spawn', JSON.stringify({model: row.model, plate: row.plate, state: row.state}))};
			if (row.state == 2 ) {
				state = 'Fourrière';
				color = 'color:red;';
			}
			/* A faire
			if (row.state == 1) {
				action = function() {
					store.commit('SET_MENU', fourriere );
					currentvhl.model = row.model;
					currentvhl.plate = row.plate;
				};

			}
			*/
			store.commit('ADD_ITEM', {
				visible: true,
				key: row.key,
				value: [{n1: state, s1:color},{n1: row.plate}],
				action: action
			})
		}

	}.bind(this);
	window.addEventListener('message', this.message);
});

