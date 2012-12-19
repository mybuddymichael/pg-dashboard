root = this
$ = root.jQuery

Dashboard = root.Dashboard = root.Dashboard ? {}
utils = Dashboard.utils = {}

$(document).ready ->
  new Dashboard.utils.AutoRefresher()
  setInterval(clock_count, 1000)

clock_count = ->
  time = new Date().toString()
  $('.clock').html time

class utils.AutoRefresher
  constructor: ->
    @$icps = $(".icps")
    @$timer = $("#timer")
    @refresh_time_in_sec = 30
    @refresh_interval
    @start_timer()

  start_timer: =>
    @refresh_interval = setInterval(@countdown, 1000)

  countdown: =>
    if @refresh_time_in_sec > 1
      @refresh_time_in_sec -= 1
      if @refresh_time_in_sec == 1
        $(".refresh_div").text("refreshing in " +
          @refresh_time_in_sec + " second...")
      else
        $(".refresh_div").text("refreshing in " +
          @refresh_time_in_sec + " seconds...")

    else
      @refresh_time_in_sec = 30
      clearInterval(@refresh_interval)
      @update_data()


  update_data: =>
    _this = this

    $.ajax
      beforeSend: ->
        $(".refresh_div").text('refreshing')
        $(".refresh_div").addClass('pulse')
      dataType: "html"
      url: utils.url_map.index
      success: (data) -> $(".content").html data
      complete: ->
        $(".refresh_div").removeClass('pulse')
        $(".refresh_div").text("refreshing in " + _this.refresh_time_in_sec + " seconds")
        _this.start_timer()
