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
    return unless @_id
    action = @computeAction(@_aasm_state)
    this.fire('change-state', {id: @_id, state: action + '!'}) if action

  copmuteButton: (state)->
    state isnt 'delivered'
