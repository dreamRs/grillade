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
    Shiny.renderContent(el, data.content);
    //$(el).find(".grillade-widget").height(data.outputHeight);
    //$(el).find(".html-widget").height(data.outputHeight);
    //$(el).find(".shiny-plot-output").height(data.outputHeight);
    $(el).find(".shiny-plot-output").each(function() {
      $(this).trigger( "resize" );
    });
  }
});
Shiny.outputBindings.register(grilladeOutputBinding, "grillade.grilladeOutput");

