function toggleDisplay(e, display) {
	if (e.style.display == display) {
		e.style.display = 'none';
	} else {
		e.style.display = display;
	}
}

function toggleForecast() {
	toggleDisplay(document.querySelector('#forecast'), 'table');
	toggleDisplay(document.querySelector('#temperature'), 'block');
	toggleDisplay(document.querySelector('#wind'), 'block');
}

function updateForecast(data) {
	var f = document.querySelector('#forecast');
	var t = document.querySelector('#temperature');
	var w = document.querySelector('#wind');

	var forecastData = JSON.parse(data.forecast)

	f.innerHTML = '';

	for (var i = 0; i < forecastData.length; ++i) {
		var hour = document.createElement('div');
		hour.className = 'forecast-hour';
		
		var time = document.createElement('div');
		time.className = 'forecast-time';
		time.innerHTML = forecastData[i].time;
		
		var weather = document.createElement('div');
		weather.className = 'forecast-weather';
		weather.innerHTML = forecastData[i].weather;

		var wind = document.createElement('div');
		wind.className = 'forecast-wind';
		wind.innerHTML = forecastData[i].wind;

		hour.appendChild(time);
		hour.appendChild(weather);
		hour.appendChild(wind);
		f.appendChild(hour);
	}

	t.innerHTML = data.temperature;

	w.innerHTML = data.wind;
}

function openAdminUi(data) {
	document.querySelector('#admin-ui').style.display = 'block';
}

function updateAdminUi(data) {
	var weatherTypes = JSON.parse(data.weatherTypes);
	var weatherIcons = JSON.parse(data.weatherIcons);
	var curHour = document.querySelector('#cur-hour');
	var curMin = document.querySelector('#cur-min');
	var curSec = document.querySelector('#cur-sec');
	var timescale = document.querySelector('#cur-timescale');
	var weather = document.querySelector('#cur-weather-type');
	var windDirection = document.querySelector('#cur-wind-direction');
	var windSpeed = document.querySelector('#cur-wind-speed');
	var syncDelay = document.querySelector('#sync-delay');

	curHour.value = data.hour;
	curMin.value = data.min;
	curSec.value = data.sec;
	timescale.value = data.timescale;
	weather.value = weatherIcons[data.weather] + ' ' + data.weather;
	windDirection.value = data.windDirection;
	windSpeed.value = data.windSpeed;
	syncDelay.value = data.syncDelay;

	var weatherSelect = document.querySelector('#new-weather-type');
	if (!weatherSelect.querySelector('option')) {
		for (i = 0; i < weatherTypes.length; ++i) {
			var option = document.createElement('option');
			option.value = weatherTypes[i];
			option.innerHTML = weatherTypes[i];
			weatherSelect.appendChild(option);
		}
	}
}

window.addEventListener('message', function (event) {
	switch (event.data.action) {
		case 'toggleForecast':
			toggleForecast();
			break;
		case 'updateForecast':
			updateForecast(event.data);
			break;
		case 'openAdminUi':
			openAdminUi();
			break;
		case 'updateAdminUi':
			updateAdminUi(event.data);
			break;
	}
});

window.addEventListener('load', function() {
	document.querySelector('#apply-time-btn').addEventListener('click', function(event) {
		var hour = document.querySelector('#new-hour');
		var min = document.querySelector('#new-min');
		var sec = document.querySelector('#new-sec');
		var transition = document.querySelector('#time-transition');
		var freeze = document.querySelector('#time-freeze');

		fetch('https://' + GetParentResourceName() + '/setTime', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				hour: parseInt(hour.value),
				min: parseInt(min.value),
				sec: parseInt(sec.value),
				transition: parseInt(transition.value),
				freeze: freeze.checked
			})
		});
	});

	document.querySelector('#apply-timescale-btn').addEventListener('click', function(event) {
		var timescale = document.querySelector('#new-timescale')

		fetch('https://' + GetParentResourceName() + '/setTimescale', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				timescale: parseFloat(timescale.value)
			})
		});
	});

	document.querySelector('#apply-weather-btn').addEventListener('click', function(event) {
		var weather = document.querySelector('#new-weather-type');
		var transition = document.querySelector('#weather-transition');
		var freeze = document.querySelector('#weather-freeze');
		var permanentSnow = document.querySelector('#weather-permanent-snow');

		fetch('https://' + GetParentResourceName() + '/setWeather', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				weather: weather.value,
				transition: parseFloat(transition.value),
				freeze: freeze.checked,
				permanentSnow: permanentSnow.checked
			})
		});
	});

	document.querySelector('#apply-wind-btn').addEventListener('click', function(event) {
		var windDirection = document.querySelector('#new-wind-direction');
		var windSpeed = document.querySelector('#new-wind-speed');
		var freeze = document.querySelector('#wind-freeze');

		fetch('https://' + GetParentResourceName() + '/setWind', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				windSpeed: parseFloat(windSpeed.value),
				windDirection: parseFloat(windDirection.value),
				freeze: freeze.checked
			})
		});
	});

	document.querySelector('#apply-sync-delay-btn').addEventListener('click', function(event) {
		var syncDelay = document.querySelector('#sync-delay');

		fetch('https://' + GetParentResourceName() + '/setSyncDelay', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				syncDelay: parseInt(syncDelay.value)
			})
		});
	});

	document.querySelector('#admin-ui-close-btn').addEventListener('click', function(event) {
		document.querySelector('#admin-ui').style.display = 'none';

		fetch('https://' + GetParentResourceName() + '/closeAdminUi', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: "{}"
		});
	});
});
