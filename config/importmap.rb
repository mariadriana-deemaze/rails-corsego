# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "flowbite", to: "https://unpkg.com/flowbite@1.6.0/dist/flowbite.turbo.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.js"
pin "tom-select", to: "https://cdn.jsdelivr.net/npm/tom-select@2.2.2/dist/js/tom-select.complete.js"
