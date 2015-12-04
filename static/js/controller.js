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
		vm.newAlert.type="";
		vm.submitted = false;
		vm.personAdd = false;
		vm.showCrisesParTypes = false;
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

	vm.getListCrisesFor = function(type){
		vm.sortCrisesByType();
		return vm.crisesParType[type];
	}

	vm.saveNewAlert = function(){
		var date = new Date();
		//vm.newAlert.dateEmission = date.getDate()+"/"+(date.getMonth()+1)+"/"+ date.getFullYear();
		vm.Request.saveNewAlert(vm.newAlert).then(function(){
			vm.crises.push(vm.newAlert);
			vm.newAlert = {};
		});
	}

	function addPerson(person){
		if(vm.newAlert.personnes === undefined){
			vm.newAlert.personnes = [];
		}
		if(vm.newAlert.personnes.indexOf(person)<0){
			vm.newAlert.personnes.push(person);
		}
	}

	vm.submitUser = function(){
		//if (vm.signUpForm.$valid) {
			console.log("is valide");
			//save to newPersonn
			addPerson(vm.newUser);
			//then
			vm.newUser = {};
			vm.personAdd = false;
		//} else {
		//	vm.submitted = true;
		//	console.log("is NOT valide");
		//}
	}

	function classCrisesByDateIntervention() {
		vm.crises.forEach(function (crise) {
			if (vm.crisesParDate[crise.dateIntervention] === undefined) {
				vm.crisesParDate[crise.dateIntervention] = [];
			}
			if (vm.crisesParDate[crise.dateIntervention].indexOf(crise) < 0) {
				vm.crisesParDate[crise.dateIntervention].push(crise);
			}
		})
	}

	vm.sortByDateIntervention = function(){
		//RESEAU DE NEURONES
		//en fonction du type, de la priorit� du temps

		vm.getListeCrises().then(function(){
			vm.crisesParDate= {};
			classCrisesByDateIntervention();
		});



	}

	vm.submitUser = function(){
		//if (vm.signUpForm.$valid) {
			console.log("is valide");
			//save to newPersonn
			addPerson(vm.newUser);
			//then
			vm.newUser = {};
			vm.personAdd = false;
		//} else {
		//	vm.submitted = true;
		//	console.log("is NOT valide");
		//}
	}

	vm.sortByDateIntervention = function(){
		//RESEAU DE NEURONES
		//en fonction du type, de la priorité du temps

		vm.getListeCrises();
		vm.crisesParDate= {};

		vm.crises.forEach(function(crise){
			if(vm.crisesParDate[crise.dateIntervention] === undefined){
				vm.crisesParDate[crise.dateIntervention ] = [];
			}
			if(vm.crisesParDate[crise.dateIntervention].indexOf(crise)<0){
				vm.crisesParDate[crise.dateIntervention].push(crise);
			}
		})


	}

});
