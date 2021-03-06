{relative, join} = require 'path-extra'
{_, $, $$, React, ReactBootstrap, ROOT, FontAwesome, toggleModal} = window
{$ships, $shipTypes, _ships} = window
{Label} = ReactBootstrap

getShipStatus = (shipId, goback) ->
  {_ships, _ndocks} = window
  status = -1
  # retreat status
  if escapeId? and shipId in goback
    return status = 0
  # reparing
  if shipId in _ndocks
    return status = 1
  if shipId > 0
    # special 1 locked phase 1
    if _ships[shipId].api_sally_area == 1
      return status = 2
    # special 2 locked phase 2
    else if _ships[shipId].api_sally_area == 2
      return status = 3
    # special 3 locked phase 3
    else if  _ships[shipId].api_sally_area == 3
      return status = 4
    # special 3 locked phase 3
    else if _ships[shipId].api_sally_area == 4
      return status = 5
  return status

StatusLabel = React.createClass
  shouldComponentUpdate: (nextProps, nextState) ->
    not (_.isEqual(nextProps.label, @props.label) and _.isEqual(nextProps.shipLv, @props.shipLv))
  render: ->
    <div className="status-label">
      <link rel="stylesheet" href={join(relative(ROOT, __dirname), 'statuslabel.css')} />
      {
        if @props.label?
          switch @props.label
            when 0
              <Label bsStyle="danger"><FontAwesome key={0} name='exclamation-circle' /></Label>
            when 1
              <Label bsStyle="info"><FontAwesome key={0} name='wrench' /></Label>
            when 2
              <Label bsStyle="info"><FontAwesome key={0} name='lock' /></Label>
            when 3
              <Label bsStyle="primary"><FontAwesome key={0} name='lock' /></Label>
            when 4
              <Label bsStyle="success"><FontAwesome key={0} name='lock' /></Label>
            when 5
              <Label bsStyle="warning"><FontAwesome key={0} name='lock' /></Label>
            else
              <Label bsStyle="default" style={background: "rgba(33, 33, 33, .7)"}>{@props.shipLv}</Label>

      }
    </div>

module.exports =
  reactClass: StatusLabel
  getShipStatus: getShipStatus
