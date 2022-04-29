(function() {
	let MenuTpl =
		'<div id="menu_{{_namespace}}_{{_name}}" class="menu{{#align}} align-{{align}}{{/align}}">' +
			'<div class="head"><span>{{{title}}}</span></div>' +					
				'<div class="desciption">{{{subtext}}}</div>' +
				'<div class="menu-items">' +
					'{{#elements}}' +
						'<div class="menu-item {{#selected}}selected{{/selected}}">' +
							'{{{label}}}{{#isSlider}} : &lt;{{{sliderLabel}}}&gt;{{/isSlider}}' +
						'</div>' +
										
					'{{/elements}}' +
				'</div>'+
				'<br>'+
				'{{#elements}}' +
				'{{#selected}}' +
				'<div class="desciption">{{{desc}}}</div>' +
				'{{/selected}}' +
				'{{/elements}}' +
				'<br>'+
			'</div>' +
		'</div>'
	;

    window.MenuData = {};
    MenuData.ResourceName = 'ak_menubase';
    MenuData.opened = {};
    MenuData.focus = [];
    MenuData.pos = {};

    MenuData.open = function(namespace, name, data) {
        if (typeof MenuData.opened[namespace] == 'undefined') {
            MenuData.opened[namespace] = {};
        }

        if (typeof MenuData.opened[namespace][name] != 'undefined') {
            MenuData.close(namespace, name);
        }

        if (typeof MenuData.pos[namespace] == 'undefined') {
            MenuData.pos[namespace] = {};
        }

        for (let i = 0; i < data.elements.length; i++) {
            if (typeof data.elements[i].type == 'undefined') {
                data.elements[i].type = 'default';
            }
        }

        data._index = MenuData.focus.length;
        data._namespace = namespace;
        data._name = name;

        for (let i = 0; i < data.elements.length; i++) {
            data.elements[i]._namespace = namespace;
            data.elements[i]._name = name;
        }

        MenuData.opened[namespace][name] = data;
        MenuData.pos[namespace][name] = 0;

        for (let i = 0; i < data.elements.length; i++) {
            if (data.elements[i].selected) {
                MenuData.pos[namespace][name] = i;
            } else {
                data.elements[i].selected = false;
            }
        }

        MenuData.focus.push({
            namespace: namespace,
            name: name
        });

        MenuData.render();
        $('#menu_' + namespace + '_' + name).find('.menu-item.selected')[0].scrollIntoView();
    };

    MenuData.close = function(namespace, name) {
        delete MenuData.opened[namespace][name];

        for (let i = 0; i < MenuData.focus.length; i++) {
            if (MenuData.focus[i].namespace == namespace && MenuData.focus[i].name == name) {
                MenuData.focus.splice(i, 1);
                break;
            }
        }

        MenuData.render();
    };

    MenuData.render = function() {
        let menuContainer = document.getElementById('menus');
        let focused = MenuData.getFocused();
        menuContainer.innerHTML = '';
        $(menuContainer).hide();

        for (let namespace in MenuData.opened) {
            for (let name in MenuData.opened[namespace]) {
                let menuData = MenuData.opened[namespace][name];
                let view = JSON.parse(JSON.stringify(menuData));

                for (let i = 0; i < menuData.elements.length; i++) {
                    let element = view.elements[i];

                    switch (element.type) {
                        case 'default':
                            break;

                        case 'slider': {
                            element.isSlider = true;
                            element.sliderLabel = (typeof element.options == 'undefined') ? element.value : element.options[element.value];

                            break;
                        }

                        default:
                            break;
                    }

                    if (i == MenuData.pos[namespace][name]) {
                        element.selected = true;
                    }
                }

                let menu = $(Mustache.render(MenuTpl, view))[0];
                $(menu).hide();
                menuContainer.appendChild(menu);
            }
        }

        if (typeof focused != 'undefined') {
            $('#menu_' + focused.namespace + '_' + focused.name).show();
        }

        $(menuContainer).show();

    };

    MenuData.submit = function(namespace, name, data) {
        $.post('http://' + MenuData.ResourceName + '/menu_submit', JSON.stringify({
            _namespace: namespace,
            _name: name,
            current: data,
            elements: MenuData.opened[namespace][name].elements
        }));
    };

    MenuData.cancel = function(namespace, name) {
        $.post('http://' + MenuData.ResourceName + '/menu_cancel', JSON.stringify({
            _namespace: namespace,
            _name: name,
        }));
    };

    MenuData.change = function(namespace, name, data) {
        $.post('http://' + MenuData.ResourceName + '/menu_change', JSON.stringify({
            _namespace: namespace,
            _name: name,
            current: data,
            elements: MenuData.opened[namespace][name].elements
        }));
    };

    MenuData.getFocused = function() {
        return MenuData.focus[MenuData.focus.length - 1];
    };

    window.onData = (data) => {
        switch (data.ak_menubase_action) {

            case 'openMenu': {
                MenuData.open(data.ak_menubase_namespace, data.ak_menubase_name, data.ak_menubase_data);
                break;
            }

            case 'closeMenu': {
                MenuData.close(data.ak_menubase_namespace, data.ak_menubase_name);
                break;
            }

            case 'controlPressed': {
                switch (data.ak_menubase_control) {

                    case 'ENTER': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            let menu = MenuData.opened[focused.namespace][focused.name];
                            let pos = MenuData.pos[focused.namespace][focused.name];
                            let elem = menu.elements[pos];

                            if (menu.elements.length > 0) {
                                MenuData.submit(focused.namespace, focused.name, elem);
                            }
                        }

                        break;
                    }

                    case 'BACKSPACE': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            MenuData.cancel(focused.namespace, focused.name);
                        }

                        break;
                    }

                    case 'TOP': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            let menu = MenuData.opened[focused.namespace][focused.name];
                            let pos = MenuData.pos[focused.namespace][focused.name];

                            if (pos > 0) {
                                MenuData.pos[focused.namespace][focused.name]--;
                            } else {
                                MenuData.pos[focused.namespace][focused.name] = menu.elements.length - 1;
                            }

                            let elem = menu.elements[MenuData.pos[focused.namespace][focused.name]];

                            for (let i = 0; i < menu.elements.length; i++) {
                                if (i == MenuData.pos[focused.namespace][focused.name]) {
                                    menu.elements[i].selected = true;
                                } else {
                                    menu.elements[i].selected = false;
                                }
                            }

                            MenuData.change(focused.namespace, focused.name, elem);
                            MenuData.render();
                            $.post('http://' + MenuData.ResourceName + '/playsound');

                            $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                        }

                        break;
                    }

                    case 'DOWN': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            let menu = MenuData.opened[focused.namespace][focused.name];
                            let pos = MenuData.pos[focused.namespace][focused.name];
                            let length = menu.elements.length;

                            if (pos < length - 1) {
                                MenuData.pos[focused.namespace][focused.name]++;
                            } else {
                                MenuData.pos[focused.namespace][focused.name] = 0;
                            }

                            let elem = menu.elements[MenuData.pos[focused.namespace][focused.name]];

                            for (let i = 0; i < menu.elements.length; i++) {
                                if (i == MenuData.pos[focused.namespace][focused.name]) {
                                    menu.elements[i].selected = true;
                                } else {
                                    menu.elements[i].selected = false;
                                }
                            }

                            MenuData.change(focused.namespace, focused.name, elem);
                            MenuData.render();
                            $.post('http://' + MenuData.ResourceName + '/playsound');

                            $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                        }

                        break;
                    }

                    case 'LEFT': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            let menu = MenuData.opened[focused.namespace][focused.name];
                            let pos = MenuData.pos[focused.namespace][focused.name];
                            let elem = menu.elements[pos];

                            switch (elem.type) {
                                case 'default':
                                    break;

                                case 'slider': {
                                    let min = (typeof elem.min == 'undefined') ? 0 : elem.min;

                                    if (elem.value > min) {
                                        elem.value--;
                                        MenuData.change(focused.namespace, focused.name, elem);
                                    }

                                    MenuData.render();
                                    break;
                                }

                                default:
                                    break;
                            }

                            $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                        }

                        break;
                    }

                    case 'RIGHT': {
                        let focused = MenuData.getFocused();

                        if (typeof focused != 'undefined') {
                            let menu = MenuData.opened[focused.namespace][focused.name];
                            let pos = MenuData.pos[focused.namespace][focused.name];
                            let elem = menu.elements[pos];

                            switch (elem.type) {
                                case 'default':
                                    break;

                                case 'slider': {
                                    if (typeof elem.options != 'undefined' && elem.value < elem.options.length - 1) {
                                        elem.value++;
                                        MenuData.change(focused.namespace, focused.name, elem);
                                    }

                                    if (typeof elem.max != 'undefined' && elem.value < elem.max) {
                                        elem.value++;
                                        MenuData.change(focused.namespace, focused.name, elem);
                                    }

                                    MenuData.render();
                                    break;
                                }

                                default:
                                    break;
                            }

                            $('#menu_' + focused.namespace + '_' + focused.name).find('.menu-item.selected')[0].scrollIntoView();
                        }

                        break;
                    }

                    default:
                        break;
                }

                break;
            }
        }
    };

    window.onload = function(e) {
        window.addEventListener('message', (event) => {
            onData(event.data);
        });
    };

})();