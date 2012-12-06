# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

root = this
$ = root.jQuery


Dashboard = root.Dashboard = root.Dashboard ? {}
utils = Dashboard.utils = {}

$(document).ready ->
  new Dashboard.utils.AutoRefresher()

class utils.AutoRefresher
  constructor: ->
    @$icps = $(".icps")
    @$timer = $("#timer")
    @start_timer()


  start_timer: ->
    # @refresh_interval = setInterval(_this.update_data, 5000)

  update_data: ->
    _this = this

    $.ajax
      beforeSend: null
      dataType: "json"
      url: "/dashboard"
      success: (data) ->
        # update_icps(data["all_icps"])


  update_icps: (icps) ->
    for icp in icps
      alert icp

