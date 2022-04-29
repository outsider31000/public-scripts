window.APP = {
	template: '#app_template',
	name: 'app',
	data() {
		return {
			style: CONFIG.style,
			showInput: false,
			showWindow: false,
			shouldHide: true,
			backingSuggestions: [],
			removedSuggestions: [],
			templates: CONFIG.templates,
			message: '',
			messages: [],
			oldMessages: [],
			oldMessagesIndex: -1,
			tplBackups: [],
			msgTplBackups: []
		};
	},
	destroyed() {
		//clearInterval(this.focusTimer);
		window.removeEventListener('message', this.listener);
	},
	mounted() {
		post('https://' + GetParentResourceName() + '/loaded', JSON.stringify({}));
		this.listener = window.addEventListener('message', (event) => {
			const item = event.data || event.detail; //'detail' is for debuging via browsers
			if (this[item.type]) {
				this[item.type](item);
			}
		});
	},
	watch: {
		messages() {
			if (this.showWindowTimer) {
				clearTimeout(this.showWindowTimer);
			}
			this.showWindow = true;
			this.resetShowWindowTimer();

			const messagesObj = this.$refs.messages;
			this.$nextTick(() => {
				messagesObj.scrollTop = messagesObj.scrollHeight;
			});
		},
	},
	computed: {
		suggestions() {
			return this.backingSuggestions.filter((el) => this.removedSuggestions.indexOf(el.name) <= -1);
		},
	},
	methods: {
		ON_SCREEN_STATE_CHANGE({ shouldHide }) {
			this.shouldHide = shouldHide;
		},
		ON_OPEN() {
			this.showInput = true;
			this.showWindow = true;
			if (this.showWindowTimer) {
				clearTimeout(this.showWindowTimer);
			}
			setTimeout(() => this.$refs.input.focus(), 100);
			/*this.focusTimer = setInterval(() => {
				if (this.$refs.input) {
					this.$refs.input.focus();
				} else {
					clearInterval(this.focusTimer);
				}
			}, 100);*/
		},
		ON_MESSAGE({ message }) {
			this.messages.push(message);
		},
		ON_CLEAR() {
			this.messages = [];
			this.oldMessages = [];
			this.oldMessagesIndex = -1;
		},
		ON_SUGGESTION_ADD({ suggestion }) {
			const duplicateSuggestion = this.backingSuggestions.find(a => a.name == suggestion.name);
			if (duplicateSuggestion) {
				if(suggestion.help || suggestion.params) {
					duplicateSuggestion.help = suggestion.help || "";
					duplicateSuggestion.params = suggestion.params || [];
				}
				return;
			}
			if (!suggestion.params) {
				suggestion.params = []; //TODO Move somewhere else
			}
			this.backingSuggestions.push(suggestion);
		},
		ON_SUGGESTION_REMOVE({ name }) {
			if(this.removedSuggestions.indexOf(name) <= -1) {
				this.removedSuggestions.push(name);
			}
		},
		ON_TEMPLATE_ADD({ template }) {
			if (this.templates[template.id]) {
				this.warn(`Tried to add duplicate template '${template.id}'`)
			} else {
				this.templates[template.id] = template.html;
			}
		},
		ON_UPDATE_THEMES({ themes }) {
			this.removeThemes();

			this.setThemes(themes);
		},
		removeThemes() {
			for (let i = 0; i < document.styleSheets.length; i++) {
				const styleSheet = document.styleSheets[i];
				const node = styleSheet.ownerNode;

				if (node.getAttribute('data-theme')) {
					node.parentNode.removeChild(node);
				}
			}

			this.tplBackups.reverse();

			for (const [ elem, oldData ] of this.tplBackups) {
				elem.innerText = oldData;
			}

			this.tplBackups = [];

			this.msgTplBackups.reverse();

			for (const [ id, oldData ] of this.msgTplBackups) {
				this.templates[id] = oldData;
			}

			this.msgTplBackups = [];
		},
		setThemes(themes) {
			for (const [ id, data ] of Object.entries(themes)) {
				if (data.style) {
					const style = document.createElement('style');
					style.type = 'text/css';
					style.setAttribute('data-theme', id);
					style.appendChild(document.createTextNode(data.style));

					document.head.appendChild(style);
				}

				if (data.styleSheet) {
					const link = document.createElement('link');
					link.rel = 'stylesheet';
					link.type = 'text/css';
					link.href = data.baseUrl + data.styleSheet;
					link.setAttribute('data-theme', id);

					document.head.appendChild(link);
				}

				if (data.templates) {
					for (const [ tplId, tpl ] of Object.entries(data.templates)) {
						const elem = document.getElementById(tplId);

						if (elem) {
							this.tplBackups.push([ elem, elem.innerText ]);
							elem.innerText = tpl;
						}
					}
				}

				if (data.script) {
					const script = document.createElement('script');
					script.type = 'text/javascript';
					script.src = data.baseUrl + data.script;

					document.head.appendChild(script);
				}

				if (data.msgTemplates) {
					for (const [ tplId, tpl ] of Object.entries(data.msgTemplates)) {
						this.msgTplBackups.push([ tplId, this.templates[tplId] ]);
						this.templates[tplId] = tpl;
					}
				}
			}
		},
		warn(msg) {
			this.messages.push({
				args: [msg],
				template: '^3<b>CHAT-WARN</b>: ^0{0}',
			});
		},
		clearShowWindowTimer() {
			clearTimeout(this.showWindowTimer);
		},
		resetShowWindowTimer() {
			this.clearShowWindowTimer();
			this.showWindowTimer = setTimeout(() => {
				if (!this.showInput) {
					this.showWindow = false;
				}
			}, CONFIG.fadeTimeout);
		},
		keyUp() {
			this.resize();
		},
		keyDown(e) {
			if (e.which === 38 || e.which === 40) {
				e.preventDefault();
				this.moveOldMessageIndex(e.which === 38);
			} else if (e.which == 33) {
				var buf = document.getElementsByClassName('chat-messages')[0];
				buf.scrollTop = buf.scrollTop - 100;
			} else if (e.which == 34) {
				var buf = document.getElementsByClassName('chat-messages')[0];
				buf.scrollTop = buf.scrollTop + 100;
			} else if (e.which == 9) {
				e.preventDefault();
				post('https://' + GetParentResourceName() + '/cycleChannel', '{}');
			}
		},
		moveOldMessageIndex(up) {
			if (up && this.oldMessages.length > this.oldMessagesIndex + 1) {
				this.oldMessagesIndex += 1;
				this.message = this.oldMessages[this.oldMessagesIndex];
			} else if (!up && this.oldMessagesIndex - 1 >= 0) {
				this.oldMessagesIndex -= 1;
				this.message = this.oldMessages[this.oldMessagesIndex];
			} else if (!up && this.oldMessagesIndex - 1 === -1) {
				this.oldMessagesIndex = -1;
				this.message = '';
			}
		},
		resize() {
			const input = this.$refs.input;
			input.style.height = '5px';
			input.style.height = `${input.scrollHeight + 2}px`;
		},
		send(e) {
			if(this.message !== '') {
				post('https://' + GetParentResourceName() + '/chatResult', JSON.stringify({
					message: this.message,
				}));
				this.oldMessages.unshift(this.message);
				this.oldMessagesIndex = -1;
				this.hideInput();
			} else {
				this.hideInput(true);
			}
		},
		hideInput(canceled = false) {
			if (canceled) {
				post('https://' + GetParentResourceName() + '/chatResult', JSON.stringify({ canceled }));
			}
			this.message = '';
			this.showInput = false;
			//clearInterval(this.focusTimer);
			this.resetShowWindowTimer();
		},
		setChannel({channelId}) {
			document.querySelectorAll('.channel').forEach(e => {
				if (e.id == channelId) {
					e.className = 'channel tab active-tab';
				} else {
					e.className = 'channel tab'
				}
			});
		},
		setPermissions({permissions}) {
			var perms = JSON.parse(permissions);

			if (perms.canAccessStaffChannel) {
				document.getElementById('channel-staff').style.display = 'inline-block';
			} else {
				document.getElementById('channel-staff').style.display = 'none';
			}
		},
	},
};

function colorToRgb(color) {
	return `rgb(${color[0]},${color[1]},${color[2]})`
}

var emojis = [];

function populateEmojiList(filter) {
	var emojiList = document.getElementById('emoji-list');

	emojiList.innerHTML = '';

	emojis.forEach(emoji => {
		var addToList = false;

		for (var i = 0; i < emoji[0].length; ++i) {
			if (!filter || filter == '' || emoji[0][i].toLowerCase().includes(filter.toLowerCase())) {
				addToList = true;
				break;
			}
		}

		if (addToList) {
			var div = document.createElement('div');
			div.className = 'emoji';
			div.innerHTML = emoji[1];
			div.addEventListener('click', function(event) {
				var input = document.querySelector('textarea');
				input.value = input.value + this.innerHTML;
				var evt = new Event('input');
				input.dispatchEvent(evt);
				input.focus();
			});
			div.addEventListener('mouseover', function(event) {
				document.getElementById('emoji-search').placeholder = emoji[0].join(', ');
			});
			div.addEventListener('mouseout', function(event) {
				document.getElementById('emoji-search').placeholder = 'Search...';
			});
			emojiList.appendChild(div);
		}
	});
}

window.addEventListener('load', event => {
	fetch('https://' + GetParentResourceName() + '/onLoad').then(resp => resp.json()).then(resp => {
		document.getElementById('channel-local').style.color = colorToRgb(resp.localColor);
		document.getElementById('channel-global').style.color = colorToRgb(resp.globalColor);
		document.getElementById('channel-staff').style.color = colorToRgb(resp.staffColor);

		emojis = JSON.parse(resp.emoji);
		populateEmojiList();
	});

	document.querySelectorAll('.channel').forEach(e => e.addEventListener('click', function(event) {
		fetch('https://' + GetParentResourceName() + '/setChannel', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				channelId: this.id
			})
		});
	}));

	document.querySelectorAll('.tab').forEach(e => e.addEventListener('click', function(event) {
		document.querySelector('textarea').focus();
	}));

	document.getElementById('emoji-toggle').addEventListener('click', function(event) {
		var emojiWindow = document.getElementById('emoji-window');

		if (emojiWindow.style.display == 'flex') {
			emojiWindow.style.display = 'none';
			this.className = 'tab';
		} else {
			emojiWindow.style.display = 'flex';
			this.className = 'tab active-tab';
		}
		document.querySelector('textarea').focus();
	});

	document.getElementById('emoji-search').addEventListener('input', function(event) {
		populateEmojiList(this.value);
	});

	document.querySelectorAll('.no-focus').forEach(e => e.addEventListener('focus', event => {
		event.preventDefault();

		if (event.relatedTarget) {
			event.relatedTarget.focus();
		} else {
			event.currentTarget.blur();
		}
	}));
});
