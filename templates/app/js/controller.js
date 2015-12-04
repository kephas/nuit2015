
'use strict';

var app = angular.module('helpus');

app.controller('MainCtrl', function ($http,
									 $q,
									 $scope,
									 Request) {

	var vm = this;

	initialize();

	function initialize() {
		vm.crises = [];
		vm.crisesParType = {};
		vm.newAlert = {};
		vm.personAdd = false;
		vm.showCrisesParTypes = false;
		vm.AllTypes = ["med", "evac", "assist","zombie"];
		vm.Request = Request;
	};

	function requestContentFile(url){
		return $http.get(url)
			.then(function(result){
				vm.crises =  result.data;
			});
	}
	function typeIsNotInCriseParType(type){
		return (vm.crisesParType[type] === undefined)
	}

	vm.sortCrisesByType = function () {
		vm.crises.forEach(function(alerte){
			//si le type n'est pas cirsesParTypes
			if(typeIsNotInCriseParType(alerte.type)){
				//on l'ajoute
				vm.crisesParType[alerte.type] = [];
			}
			//ensuite on ajoute l'alerte
			if(vm.crisesParType[alerte.type].indexOf(alerte)<0){
				vm.crisesParType[alerte.type].push(alerte);
			}
		});
	}

	vm.getListeCrises = function () {
		return vm.Request.getAllertes().then(function(data){
			vm.crises = data;
		});
	};


	vm.getListeCrises();

	vm.sortAndShowCrises = function(){
		vm.sortCrisesByType();
		vm.showCrisesParTypes = true;
	}

	vm.saveNewAlert = function(){
		var date = new Date();
		vm.newAlert.dateEmission = date.getDate()+"/"+(date.getMonth()+1)+"/"+ date.getFullYear();
		vm.Request.saveNewAlert(vm.newAlert);
	}


});

