root = this
$ = root.jQuery

Dashboard = root.Dashboard = root.Dashboard ? {}
utils = Dashboard.utils = {}

$ ->
  new Dashboard.utils.AutoRefresher()

class utils.AutoRefresher
  constructor: ->
    @$icps = $(".icps")
    @$timer = $("#timer")
    @start_timer()

  start_timer: ->
    @refresh_interval = setInterval(@update_data, 5000)

  update_data: =>
    _this = this

    $.ajax
      beforeSend: ->
        $("header").addClass('pulse')
      dataType: "json"
      url: "/dashboard"
      success: (data) ->
        _this.update_icps(data["all_icps"])
      complete: ->
        $("header").removeClass('pulse')

  update_icps: (icps) ->
    for icp in icps
      @$icp = $('#'+icp.name)
      @message = ''
      for message in icp.messages
        @message += '<div class="message">' + message + '</div>'
      if icp.status == 'good'
        @$icp.addClass('good')
        @$icp.removeClass('bad')
        $('#'+icp.name+' > .messages').html('')
      else
        @$icp.addClass('bad')
        @$icp.removeClass('good')
        $('#'+icp.name+' > .messages').html(@message)
