//= require action_cable
//= require_self

(function () {
  if (!this.App) this.App = {};

  App.cable = ActionCable.createConsumer();
}).call(this);
