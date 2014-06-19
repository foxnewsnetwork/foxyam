class Foxfire.PackingInputController extends Ember.ObjectController
  transportors: ["40ST", "40HC", "45ST", "45HC","20ST","20HC"]
  presentation: ~>
    @selectedPacking + " pounds in " + @selectedTransportor