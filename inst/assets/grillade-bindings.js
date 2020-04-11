// Shiny Output Bindings for Grillade
var grilladeOutputBinding = new Shiny.OutputBinding();
$.extend(grilladeOutputBinding, {
  find: function find(scope) {
    return $(scope).find(".shiny-grillade-output");
  },
  onValueError: function onValueError(el, err) {
    Shiny.unbindAll(el);
    this.renderError(el, err);
  },
  renderValue: function renderValue(el, data) {
    Shiny.renderContent(el, data);
    //Shiny.bindAll(el);
    //HTMLWidgets.staticRender();
  }
});
Shiny.outputBindings.register(grilladeOutputBinding, "grillade.grilladeOutput");

