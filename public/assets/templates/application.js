Ember.TEMPLATES.application=Ember.Handlebars.template(function(a,b,c,d,e){this.compilerInfo=[3,">= 1.0.0-rc.4"],c=c||Ember.Handlebars.helpers,e=e||{};var f="",g,h,i,j,k=c.helperMissing,l=this.escapeExpression;return e.buffer.push('<div class="container">\n    '),h={},i={},j={hash:{},contexts:[b],types:["ID"],hashContexts:i,hashTypes:h,data:e},e.buffer.push(l((g=c.render,g?g.call(b,"header",j):k.call(b,"render","header",j)))),e.buffer.push("\n    "),h={},i={},e.buffer.push(l(c._triageMustache.call(b,"outlet",{hash:{},contexts:[b],types:["ID"],hashContexts:i,hashTypes:h,data:e}))),e.buffer.push("\n    "),h={},i={},j={hash:{},contexts:[b],types:["ID"],hashContexts:i,hashTypes:h,data:e},e.buffer.push(l((g=c.render,g?g.call(b,"footer",j):k.call(b,"render","footer",j)))),e.buffer.push("\n</div>\n"),f})