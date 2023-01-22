// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';
import 'trix';
import '@rails/actiontext';
import 'flowbite';
import "chartkick";
import "Chart.bundle";
import 'jquery';
import 'sifter';
import "selectize";

$(document).ready(function(){
    console.log("Hey!")

    if ($('.selectize')){
        $('.selectize').selectize({
            sortField: 'text'
        });

    }
    
    $(".selectize-tags").selectize({
        create: function(input, callback) {
          $.post('/tags.json', { tag: { name: input } })
            .done(function(response){
              console.log(response)
              callback({value: response.id, text: response.name });
            })
        }
      });

})
