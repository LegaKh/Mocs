Polymer
  is: 'mocs-order'
  properties:
    _id: Number
    _items: Array
    _aasm_state: String

  computeAction: (state)->
    switch state
      when 'new'       then 'finalize'
      when 'finalized' then 'order'
      when 'ordered'   then 'deliver'

  performAction: ->
    this.fire('change-state', {state: @computeAction(@_aasm_state) + '!'})
