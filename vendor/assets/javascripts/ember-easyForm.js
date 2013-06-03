// ==========================================================================
// Project:   Ember EasyForm
// Copyright: ©2013 DockYar, LLC. and contributors.
// License:   Licensed under MIT license (see license.js)
// ==========================================================================


// Last commit: bbb9ad3 (2013-05-30 21:02:34 -0400)


!function(){Ember.EasyForm=Ember.Namespace.create({VERSION:"0.3.2"})}(),function(){Ember.EasyForm.Config=Ember.Namespace.create({_wrappers:{"default":{formClass:"",fieldErrorClass:"fieldWithErrors",inputClass:"input",errorClass:"error",hintClass:"hint",labelClass:"",wrapControls:!1,controlsWrapperClass:""}},_inputTypes:{},registerWrapper:function(e,t){this._wrappers[e]=Ember.$.extend({},this._wrappers["default"],t)},getWrapper:function(e){var t=this._wrappers[e];return t},registerInputType:function(e,t){this._inputTypes[e]=t},getInputType:function(e){return this._inputTypes[e]}})}(),function(){Ember.Handlebars.registerHelper("errorField",function(e,t){return this.get("errors")?(t.hash.property=e,Ember.Handlebars.helpers.view.call(this,Ember.EasyForm.Error,t)):void 0})}(),function(){Ember.Handlebars.registerHelper("formFor",function(e,t){return t.hash.contentBinding=e,Ember.Handlebars.helpers.view.call(this,Ember.EasyForm.Form,t)})}(),function(){Ember.Handlebars.registerHelper("hintField",function(e,t){return t.hash.text?Ember.Handlebars.helpers.view.call(this,Ember.EasyForm.Hint,t):void 0})}(),function(){Ember.Handlebars.registerHelper("input",function(e,t){return t.hash.inputOptions=Ember.copy(t.hash),t.hash.property=e,t.hash.isBlock=!!t.fn,Ember.Handlebars.helpers.view.call(this,Ember.EasyForm.Input,t)})}(),function(){Ember.Handlebars.registerHelper("inputField",function(e,t){var r=this,i=function(e){try{return(r.get("content")||r).constructor.metaForProperty(e).type}catch(t){return null}};if(t.hash.valueBinding=e,t.hash.viewName="inputField-"+t.data.view.elementId,t.hash.inputConfig)for(var s=t.hash.inputConfig.split(";"),n=s.length;n--;){var a=s[n].split(":");t.hash[a[0]]=a[1]}if("text"===t.hash.as)return Ember.Handlebars.helpers.view.call(r,Ember.EasyForm.TextArea,t);if("select"===t.hash.as)return delete t.hash.valueBinding,t.hash.contentBinding=t.hash.collection,t.hash.selectionBinding=t.hash.selection,t.hash.valueBinding=t.hash.value,Ember.Handlebars.helpers.view.call(r,Ember.EasyForm.Select,t);if(t.hash.as){var o=Ember.EasyForm.Config.getInputType(t.hash.as);if(o)return t.hash.property=e,Ember.Handlebars.helpers.view.call(r,o,t);t.hash.type=t.hash.as}else if(e.match(/password/))t.hash.type="password";else if(e.match(/email/))t.hash.type="email";else if(e.match(/url/))t.hash.type="url";else if(e.match(/color/))t.hash.type="color";else if(e.match(/^tel/))t.hash.type="tel";else if(e.match(/search/))t.hash.type="search";else if("number"===i(e)||"number"==typeof r.get(e))t.hash.type="number";else if("date"===i(e)||!Ember.isNone(r.get(e))&&r.get(e).constructor===Date)t.hash.type="date";else if("boolean"===i(e)||!Ember.isNone(r.get(e))&&r.get(e).constructor===Boolean)return t.hash.checkedBinding=e,Ember.Handlebars.helpers.view.call(r,Ember.EasyForm.Checkbox,t);return Ember.Handlebars.helpers.view.call(r,Ember.EasyForm.TextField,t)})}(),function(){Ember.Handlebars.registerHelper("labelField",function(e,t){return t.hash.property=e,t.hash.viewName="labelField-"+t.data.view.elementId,Ember.Handlebars.helpers.view.call(this,Ember.EasyForm.Label,t)})}(),function(){Ember.Handlebars.registerHelper("submit",function(e,t){return"object"==typeof e&&(t=e,e=void 0),t.hash.context=this,t.hash.value=e||"Submit",Ember.Handlebars.helpers.view.call(this,Ember.EasyForm.Submit,t)})}(),function(){Ember.EasyForm.BaseView=Ember.View.extend({getWrapperConfig:function(e){var t=Ember.EasyForm.Config.getWrapper(this.get("wrapper"));return t[e]},wrapper:Ember.computed(function(){for(var e=this.get("parentView");e;){var t=e.get("wrapper");if(t)return t;e=e.get("parentView")}return"default"})})}(),function(){Ember.EasyForm.Checkbox=Ember.Checkbox.extend()}(),function(){Ember.EasyForm.Error=Ember.EasyForm.BaseView.extend({tagName:"span",init:function(){var e;this._super(),this.classNames.push(this.getWrapperConfig("errorClass")),e={},e[""+this.property+"Watch"]=function(){return"string"==typeof this.get("controller.errors."+this.property)?this.get("controller.errors."+this.property):(this.get("controller.errors."+this.property)||[])[0]}.property("controller.errors."+this.property),this.reopen(e),this.set("template",Ember.Handlebars.compile("{{view."+this.property+"Watch}}"))}})}(),function(){Ember.EasyForm.Form=Ember.EasyForm.BaseView.extend({tagName:"form",attributeBindings:["novalidate"],novalidate:"novalidate",wrapper:"default",init:function(){this._super(),this.classNames.push(this.getWrapperConfig("formClass"))},submit:function(e){var t,r=this;e&&e.preventDefault(),Ember.isNone(this.get("context.validate"))?this.get("controller").send("submit"):(t=Ember.isNone(this.get("context").validate)?this.get("context.content").validate():this.get("context").validate(),t.then(function(){r.get("context.isValid")===!0&&r.get("controller").send("submit")}))}})}(),function(){Ember.EasyForm.Hint=Ember.EasyForm.BaseView.extend({tagName:"span",init:function(){this._super(),this.classNames.push(this.getWrapperConfig("hintClass")),this.set("template",Ember.Handlebars.compile(this.get("text")))}})}(),function(){Ember.EasyForm.Input=Ember.EasyForm.BaseView.extend({init:function(){this._super(),this.classNameBindings.push("error:"+this.getWrapperConfig("fieldErrorClass")),this.classNames.push(this.getWrapperConfig("inputClass")),this.isBlock||this.set("template",Ember.Handlebars.compile(this.fieldsForInput())),Ember.isNone(this.get("context.errors"))||this.reopen({error:function(){return void 0!==this.get("context").get("errors").get(this.property)}.property("context.errors."+this.property)})},tagName:"div",classNames:["string"],didInsertElement:function(){this.set("labelField-"+this.elementId+".for",this.get("inputField-"+this.elementId+".elementId"))},concatenatedProperties:["inputOptions"],inputOptions:["as","placeholder","inputConfig","collection","prompt","optionValuePath","optionLabelPath","selection","value"],fieldsForInput:function(){return this.labelField()+this.wrapControls(this.inputField()+this.errorField()+this.hintField())},labelField:function(){var e=this.label?'text="'+this.label+'"':"";return"{{labelField "+this.property+" "+e+"}}"},inputField:function(){for(var e,t="",r=this.inputOptions,i=0;i<r.length;i++)e=r[i],this[e]&&("boolean"==typeof this[e]&&(this[e]=e),t=t.concat(""+e+'="'+this[r[i]]+'"'));return t.replace(/^\s\s*/,"").replace(/\s\s*$/,""),"{{inputField "+this.property+" "+t+"}}"},errorField:function(){var e="";return"{{#if errors."+this.property+"}}{{{errorField "+this.property+" "+e+"}}{{/if}}"},hintField:function(){var e=this.hint?'text="'+this.hint+'"':"";return"{{hintField "+this.property+" "+e+"}}"},wrapControls:function(e){return this.getWrapperConfig("wrapControls")?'<div class="'+this.getWrapperConfig("controlsWrapperClass")+'">'+e+"</div>":e},focusOut:function(){Ember.isNone(this.get("context.validate"))||(Ember.isNone(this.get("context").validate)?this.get("context.content").validate(this.property):this.get("context").validate(this.property))}})}(),function(){Ember.EasyForm.Label=Ember.EasyForm.BaseView.extend({tagName:"label",attributeBindings:["for"],init:function(){this._super(),this.classNames.push(this.getWrapperConfig("labelClass")),this.set("template",this.renderText())},renderText:function(){return Ember.Handlebars.compile(this.text||this.property.underscore().split("_").join(" ").capitalize())}})}(),function(){Ember.EasyForm.Select=Ember.Select.extend()}(),function(){Ember.EasyForm.Submit=Ember.View.extend({tagName:"input",attributeBindings:["type","value"],type:"submit",init:function(){this._super(),this.set("value",this.value)},onClick:function(){this.get("context").validate()&&this.get("controller").send("submit")}})}(),function(){Ember.EasyForm.TextArea=Ember.TextArea.extend()}(),function(){Ember.EasyForm.TextField=Ember.TextField.extend()}(),function(){Ember.TEMPLATES["easyForm/input"]=Ember.Handlebars.compile('<label {{bindAttr for="labelFor"}}>{{labelText}}</label>')}(),function(){Ember.EasyForm.objectNameFor=function(e){var t=e.constructor.toString().split(".");return t[t.length-1].underscore()}}(),"undefined"==typeof location||"localhost"!==location.hostname&&"127.0.0.1"!==location.hostname||Ember.Logger.warn("You are running a production build of Ember on localhost and won't receive detailed error messages. If you want full error messages please use the non-minified build provided on the Ember website.");