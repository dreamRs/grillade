HTMLWidgets.widget({

  name: "grillade",

  type: "output",

  factory: function(el, width, height) {

    var html, classGrid;

    return {

      renderValue: function(x) {

        classGrid = x.params.class;
        html = x.html;
        el.classList.add(classGrid);
        if (classGrid == "autogrid") {
          el.style.gridTemplateColumns = "repeat(auto-fit, minmax(100px, 1fr))";
        }
        //el.style.gridTemplateRows = "repeat(auto-fit, minmax(100px, 1fr))";
        el.innerHTML = html;
        HTMLWidgets.staticRender();

      },

      resize: function(width, height) {
      }

    };
  }
});
