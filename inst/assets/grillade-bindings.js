// Shiny Output Bindings for Grillade
var grilladeOutputBinding = new Shiny.OutputBinding();
$.extend(grilladeOutputBinding, {
  find: function find(scope) {
    return $(scope).find(".grillade-output");
  },
  onValueError: function onValueError(el, err) {
    Shiny.unbindAll(el);
    this.renderError(el, err);
  },
  renderValue: function renderValue(el, data) {
    Shiny.renderContent(el, data);
  }
});
outputBindings.register(grilladeOutputBinding, "grillade.grilladeOutput");

