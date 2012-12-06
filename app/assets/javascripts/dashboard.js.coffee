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
    @refresh_time_in_sec = 10
    @refresh_interval
    @start_timer()

  start_timer: =>
    @refresh_interval = setInterval(@countdown, 1000)

  countdown: =>
    if @refresh_time_in_sec > 1
      @refresh_time_in_sec -= 1
      if @refresh_time_in_sec == 1
        $("header").text("refreshing in " +
          @refresh_time_in_sec + " second...")
      else
        $("header").text("refreshing in " +
          @refresh_time_in_sec + " seconds...")

    else
      @refresh_time_in_sec = 10
      clearInterval(@refresh_interval)
      @update_data()


  update_data: =>
    _this = this

    $.ajax
      beforeSend: ->
        $("header").text('refeshing')
        $("header").addClass('pulse')
      dataType: "json"
      url: "/dashboard"
      success: (data) ->
        _this.update_icps(data["all_icps"])
      complete: ->
        $("header").removeClass('pulse')
        $("header").text("refreshing in " + _this.refresh_time_in_sec + " seconds")
        _this.start_timer()

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
