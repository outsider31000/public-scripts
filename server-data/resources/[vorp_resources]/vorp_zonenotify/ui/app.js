const { createApp } = Vue

  createApp({
    data() {
      return {
        district: 'Unknown',
        town: 'Unknown',
        time: '10:00:00am',
        temp: '0°c',
        state: 'Ambarino',
        printed: 'return "Unknown"',
        written: 'Unknown',
        visible: false
      }
    },
    mounted() {
        window.addEventListener('message', this.onMessage);
    },
    destroyed() {
        window.removeEventListener('message')
    },
    computed: {
      title() {
        if (this.town != 'Unknown' && this.town) {
          return this.town.replace(/[A-Z]/g, ' $&').trim()
        } 
        else if (this.printed != 'Unknown' && this.printed) {
          return this.printed.replace(/P\_[0-9]\_/g, '').replace(/\_/g, ' $&').trim()
        }
        else if (this.written != 'Unknown' && this.written) {
          return this.written.replace(/W\_[0-9]\_/g, '').replace(/\_/g, ' $&').trim()
        }
        else if (this.district != 'Unknown' && this.district) {
          return this.district.replace(/[A-Z]/g, ' $&').trim()
        } else {
          return ''
        }
      }
    },
    methods: {
        onMessage(event) {
            if (event.data.type === 'openzone') {
                this.district = event.data.district
                this.town = event.data.town
                this.time = event.data.time
                this.temp = event.data.temp
                this.wind = event.data.wind
                this.state = event.data.state
                this.written = event.data.written
                this.printed = event.data.printed


                this.visible = true

                let that = this
                setTimeout(() => {
                    that.visible = false    
                }, 4000);
            } 
        },
    }
  }).mount('#app')