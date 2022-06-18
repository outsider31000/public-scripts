const { createApp } = Vue;

createApp({
  data() {
    return {
      devMode: false,
      visible: false,
      showInput: false,
      style: {
        fontSize: 'm'
      },
      job: null,
      language: {},
      location: {},
      categories: [],
      consumables: {},
      currentRoute: 'home',
      activeCraftable: null,
      quantity: 1,
      min: 1,
      max: 10,
      crafttime: 15000,
      testData: [
        {
          Text: "Meat Bfast ",
          SubText: "InvMax = 10",
          Desc: "Recipe: 1x Apple, 1x Water, 1x Sugar, 1x Egg, 1x Flour",
          Items: [
              {
                  name: "meat",
                  count: 1
              },
              {
                  name: "salt",
                  count: 1
              }
          ],
          Reward: [
              {
                  name: "consumable_breakfast",
                  count: 1
              }
          ],
          Job: 0, 
          Location: 0,
          Category: "food"
        }
      ],
      testCategory: [
        {
          ident: 'food', 
          text: 'Craft Food'
        }
      ]
    };
  },
  mounted() {
    // Window Event Listeners
    window.addEventListener("message", this.onMessage);
    window.addEventListener("keydown", this.onKeypress)

    // Debug only
    if (this.devMode) {
      let devData = {
        craftables: this.testData,
        categories: this.testCategory,
        crafttime: 15000,
        style: {
          fontSize: 'm'
        },
        language: {
          InputHeader: 'How many {{msg}} you want to craft',
          InputCraft: 'Craft Item',
          InputCancel: 'Cancel',
          BackButton: 'Back',
          ExitButton: 'Exit',
          CraftHeader: 'Crafting',
          CraftText: 'Press [~e~G~q~] to Craft',
          InvalidAmount: 'Invalid Amount',
          Crafting: 'Crafting...',
          FinishedCrafting: 'You finished crafting',
          PlaceFire: "You're placing a campfire...",
          PutOutFire: 'Putting out the campfire...',
          NotEnough: 'Not enough material for this recipe',
          NotJob: 'You dont have the required job '
        }
      }
      this.setData(devData)
      this.visible = true
    }
  },
  destroyed() {
    // Remove listeners when UI is destroyed to save on memory
    window.removeEventListener("message");
    window.removeEventListener('keydown')
  },
  computed: {
    fontClass() {
      let fontc = {}

      switch(this.style.fontSize) {
        case 's':
          fontc['smallfont'] = true
          break;
        case 'm':
          fontc['mediumfont'] = true
          break;
        case 'l':
          fontc['largefont'] = true
          break;
        default:
          break; 
      }

      return fontc
    },
    InputCraftText() {
      return  this.activeCraftable.Text && this.language.InputHeader ? this.language.InputHeader.replace('{{msg}}', this.activeCraftable.Text) : ''
    }
  },
  methods: {
    onMessage(event) {
      switch(event.data.type) {
        case "vorp-craft-open":
          this.setData(event.data)
          this.visible = true;
          break;
        case "vorp-craft-animate":
          this.animationPlaying()
          break;
        default:
          break;
      }
    },
    onKeypress(event) {
      if (event.key === "I" || event.key === "i") {
        fetch(`https://${GetParentResourceName()}/vorp-openinv`, {
          method: 'POST'
        })
      }

      if (event.key === "Escape" || event.key === "esc") {
        this.currentRoute = 'home'
        this.closeView()
      }
    },
    animationPlaying() {
      this.visible = false
        
      setTimeout(()=>{
        this.visible = true
      }, this.crafttime);
    },
    craftItem() {
      fetch(`https://${GetParentResourceName()}/vorp-craftevent`, {
        method: 'POST',
        body: JSON.stringify({
          craftable: this.activeCraftable,
          quantity: this.quantity,
          location: this.location
        })
      }).then(resp => resp.json()).then(resp => {
        this.showInput = false
        this.activeCraftable = null
        this.quantity = 1
      }).catch(function (error) {
        console.warn(error);
      })
    },
    handleItemClick(data) {
      this.activeCraftable = data
      this.showInput = true
    },
    formatQuantity() {
      if (this.quantity <= this.min - 1) {
          this.quantity = this.min
      }

      if (this.quantity > this.max) {
          this.quantity = this.max
      }
    },
    increase() {
        let value = this.quantity
        value = isNaN(value) ? this.min : value;

        if (value >= this.max) {
            value = this.max - 1
        }

        value++;
        this.quantity = value
    },
    decrease() {
        let value = this.quantity
        value = isNaN(value) ? this.min : value;
        value < this.min ? value = this.min : '';
        value--;
        value < this.min ? value = this.min : '';
        this.quantity = value
    },
    closeView() {
      this.visible = false;
      fetch(`https://${GetParentResourceName()}/vorp-craft-close`, {
        method: 'POST'
      })
    },
    setData(data) {
      let craftables = data.craftables
      let categories = data.categories
      let crafttime = data.crafttime
      let style = data.style
      let language = data.language
      let location = data.location
      let job = data.job

      let consumables = {}
      let filteredcat = []
      // Setup object with keys
      categories.forEach(cata => {
        consumables[cata.ident] = []
        let jobcheck = false
        // Job is set to specific jobs
        if (cata.Job !== 0) {

          let ln = cata.Job.length
          let ps = 0
          for (ps; ps < ln; ps++) {
            let currentjob = cata.Job[ps]
            if (currentjob == job) {
              jobcheck = true
              break
            }
          }
        } else {
          jobcheck = true
        }

        if (jobcheck == true) {
          if (cata.Location == 0) {
            filteredcat.push(cata)
          } else {
            let l = cata.Location.length
            let pos = 0
            for (pos; pos < l; pos++) {
              let loc = cata.Location[pos]
              if (loc == location?.id) {
                filteredcat.push(cata)
                break
              }
            }
          }
        }
      });



      // Fill object created above
      craftables.forEach(item => {
        let jobcheck = false
        if (item.Job !== 0) {
          let ln = item.Job.length
          let ps = 0
          for (ps; ps < ln; ps++) {
            let currentjob = item.Job[ps]
            if (currentjob == job) {
              jobcheck = true
              break
            }
          }
        } else {
          jobcheck = true
        }

        if (jobcheck == true) {
          // Filter out locations
          if (item.Location == 0) {
            consumables[item.Category].push(item)
          } else {
            let l = item.Location.length
            let pos = 0
            for (pos; pos < l; pos++) {
              let loc = item.Location[pos]
              if (loc == location?.id) {
                consumables[item.Category].push(item)
                break
              }
            }
          } 
        }
      });


      this.language = language
      this.consumables = consumables
      this.categories = filteredcat
      this.crafttime = crafttime
      this.style = style
      this.location = location
    }
  },
}).mount("#app");
