let currentspawnable = 0;
let currentvhl = {
	model: '',
	plate: ''
};


let vehicles = {
	title: 'Vehicules',
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
	onItemChange: function(index){
		if (index != 0) {
			$.post("http://veh_shop/showcase", JSON.stringify({model: store.state.currentMenu.items[index].key}))
		} else {
			$.post("http://veh_shop/showcase", JSON.stringify({model: false}))
		}
	},
	index: 0
};

let main =  {
	title: 'Concessionnaire',
	subtitle: 'Actions',
	limit: 10,
	items: [
		{ key: 'Acheter un véhicule', action: function(){ store.commit('SET_MENU', vehicles); $.post("http://veh_shop/init", JSON.stringify({spawnable: currentspawnable}))}},
		{ style: 'red button', key: 'Fermer', action: function(){
			$.post('http://veh_shop/close', JSON.stringify({}));
			$.post('http://veh_shop/removeold', JSON.stringify({}));
		}}
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
			let action = function() {$.post('http://veh_shop/buy', JSON.stringify({model: row.model, name: row.model, price: row.price, type: row.type}))};

			store.commit('ADD_ITEM', {
				visible: row.visible,
				key: row.key,
				value: row.price.toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1 ") + ' $' ,
				action: action
			})
		}

	}.bind(this);
	window.addEventListener('message', this.message);
});
