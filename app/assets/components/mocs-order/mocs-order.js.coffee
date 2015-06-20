Polymer
  is: 'mocs-order'
  properties:
    id: Number
    items: Array
    aasm_state: String

  computeAction: (state)->
    switch state
      when 'new'       then 'finalize'
      when 'finalized' then 'order'
      when 'ordered'   then 'deliver'

  performAction: ->
    return unless @id
    action = @computeAction(@aasm_state)
    this.fire('change-state', {id: @id, state: action + '!'}) if action

  copmuteButton: (state)->
    state isnt 'delivered'
